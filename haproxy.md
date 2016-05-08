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

### Tuning multi-coeurs

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
