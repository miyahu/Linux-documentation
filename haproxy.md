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
```bash
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

#### Encore..

Session state at disconnection
------------------------------
status de la connexion, de 4 caractères en HTTP mode

"On the first character, a code reporting the first event which caused the
    session to terminate" 

exemple, les probes fortigate par exemples
```
CD-- 
```
C : "the TCP session was unexpectedly aborted by the client"
D : "the session was in the DATA phase"
A
exemple, les web scénarios Zabbix
```
LR--
```
L : "the session was locally processed by haproxy and was not passed to
            a server. This is what happens for stats and redirects."
R : "the proxy was waiting for a complete, valid REQUEST from the client
            (HTTP mode only). Nothing was sent to any server."


#### afficher les status différents de normaux

```bash
awk '$28 !~ /----/ {print$12" "$28}'  /var/log/haproxy.log
```

#### afficher les ressources avec le status CD

```bash
awk '$28 ~ /CD--/ {print"ip: "$6" ressources: "$12" status: "$28}'  /var/log/haproxy.log
```

#### n'affiche pas les PR/LR/SSL handshake failure
```bash
awk '$28 !~ /----|PR--|LR--/ && !/SSL handshake failure/ {print}'  haproxy.log.4 | less
```

```bash
CD   The client unexpectedly aborted during data transfer. This can be
          caused by a browser crash, by an intermediate equipment between the
          client and haproxy which decided to actively break the connection,
          by network routing issues between the client and haproxy, or by a
          keep-alive session between the server and the client terminated first
          by the client.

```

### afficher les codes 503 ainsi que leur status 

```bash
awk '$14 == 503 && $28 !~ /---/ {print" ressource: "$12 "hap status: "$28}'    /var/log/haproxy.log |less
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

### ressources avec le détails

https://www.haproxy.com/blog/haproxy-log-customization/


### Ezplication !!!

1:  date et heure
2:  nom du serveur traitant la requête
3:  nom et pid du processus  traitant la requête
4:  adresse IP du client direct
9:  méthode      
10: ressource appelée
11: protocole et version     
12: code retour
13: code retour
14:
18: "frontend" utilisé
19: "backend" utilisé
20: "server" utilisé
26: status hap du traitement de la requête
36: domaine et ressource appelé
37: user agent
39: adresse IP extraite du X-Forwarded-For 


```
(1)2017-10-26T11:28:03.197542+02:00 (2)ctsprdweb01 (3)haproxy[2736]: (4)10.0.132.254 (5)- (6)- (7)[26/Oct/2017:09:28:02 (8)+0000] (9)"POST (10)/masseur-kinesitherapeute/exercice-liberal/facturation-remuneration/tarifs/tarifs (11)HTTP/1.1" (12)302 (13)503 (14)"" (15)"" (16)(168884 (17)821 (18)"public_http" (19)"apache" (20)"apache" (21)0 (22)0 (23)1 (24)225 (25)226 (26)---- (27)19 (28)19 (29)0 (30)1 (31)0 (32)0 (33)0 (34)"" (35)"" (36)"https://www.ameli.fr/masseur-kinesitherapeute/exercice-liberal/f" (37)"Mozilla/5.0 (Windows NT 6.1; rv:56.0) Gecko/20100101 Firefox/56.0" (38)"www.ameli.fr" (39)"105.159.133.89"
```

### haproxy sous docker 

https://hub.docker.com/_/haproxy/
