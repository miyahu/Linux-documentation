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
