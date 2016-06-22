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
