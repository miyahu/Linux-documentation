###Tester sa conf haproxy
```
haproxy -f /etc/haproxy/haproxy.cfg -c
```

### Obtenir des stats sur l'état de santé des backend
```
echo "show servers state" | socat /var/run/haproxy/admin.sock stdio
```
### désactiver un backend 
```
echo "disable server bk_eol/tagada2" | socat /var/run/haproxy/admin.sock stdio
```
### utiliser hatop
```
hatop -s  /run/haproxy/admin.sock
```
### socket avec accès tcp 
```
stats socket ipv4@0.0.0.0:666 level admin
```
### Activer les logs

Comme haproxy tourne dans un chroot, il est nécessaire d'utiliser un socket réseau pour communiquer 

Côté haproxy :
```
log 127.0.0.1   syslog notice
```
Côté rsyslog
```
$ModLoad imudp
$UDPServerRun 514
```
Puis rechargement des démons. 

### multi process

ce mode est à éviter par défaut, contre indication :
**pas de mémoire partagée en les process**
ce qui entraine que toute les informations sont uniquement présentes dans un process :
* pas de partage des stats (obligation d'itérer ...)
* pas de partage de l'état des backends (multiplication des checks)
* pas de partage de l'état des backends (obligation d'itérer ...)
* etc ...
 
Il n'est principalement recommandé que lors de l'offload SSL, et encore ...  
#### Tuning multi-coeurs

En configuration multi-coeur nbproc > 1

désactiver irqbalance.

## Tuning
### Keep-alive
#### uniquement côté client
Feature 1.4 

`option http-server-close`

Cette directive maintien le keep-alive côté client mais ferme celle côté serveur après chaque requête, pas idéal
#### De bout en bout 
Feature 1.5
`option http-keep-alive`
`option prefer-last-server`
La seconde option permet d'utiliser une connexion existant de préférence (logique!) 

### troubleshooting

Utiliser hatop et vérifier

* qmax
* qcurrent
* smax
* scurrent

### ajouter un entête sur le trafic sortant (troubleshooting)

`http-response set-header X-Test ok` dans le block backend

### stats haproxy 1.5
`echo "show stat" | socat /run/haproxy/admin.sock stdio | awk -F ',' '{print"frontend:"$1" backend:"$2" status:"$18" qcur:"$3" qmax:"$4" scur:"$5" smax:"$6}'`

### error 504 

augmenter les valeurs des times out

server et ou client

### analyser les logs

https://cbonte.github.io/haproxy-dconv/1.7/configuration.html#8.5

Exemple 
```
May 23 11:33:49 cprdweb02 haproxy[14889]: 10.0.12.24 - - [23/May/2017:09:33:49 +0000] "GET /entree.min.js HTTP/1.1" 200 12873 "" "" 14987 723 "http" "toto" "toto" 0 0 0 34 34 ---- 25 25 10 11 0 0 0 "" "" "https://www.google.fr/search?ei=1gEkWaPsHYL2aNnVv3A&q=gruik" "Mozilla/5.0 (Linux; Android 5.1.1; SM-G361F Build/LMY48B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.132 Mobile Safari/537.36" "tralala" 
```

La présence du sH nous indique 

```
sH   The "timeout server" stroke before the server could return its
          response headers. This is the most common anomaly, indicating too
          long transactions, probably caused by server or database saturation.
          The immediate workaround consists in increasing the "timeout server"
          setting, but it is important to keep in mind that the user experience
          will suffer from these long response times. The only long term
          solution is to fix the application.
```

### afficher les status différents de normaux

```bash
awk '$28 !~ /----/ {print$12" "$28}'  /var/log/haproxy.log
```

### afficher les ressources avec le status CD

```bash
awk '$28 ~ /CD--/ {print"ip: "$6" ressources: "$12" status: "$28}'  /var/log/haproxy.log
```

### n'affiche pas les PR/LR/SSL handshake failure
```bash
awk '$28 !~ /----|PR--|LR--/ && !/SSL handshake failure/ {print}'  haproxy.log.4 | less
```

```
CD   The client unexpectedly aborted during data transfer. This can be
          caused by a browser crash, by an intermediate equipment between the
          client and haproxy which decided to actively break the connection,
          by network routing issues between the client and haproxy, or by a
          keep-alive session between the server and the client terminated first
          by the client.

```

### insérer l'adresse IP du X-Forward-For dans les logs

Ajouter \ %hr au log-format 

```
log-format %ci\ -\ [%T]\ %{+Q}r\ %ST\ %B\ %{+Q}hrl\ %hs
```
et capturer les 50 premier octets de l'entête X-Forward-For

```
capture request header X-Forwarded-For  len 50
```

