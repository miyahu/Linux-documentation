###Tester sa conf haproxy
```
haproxy -f /etc/haproxy/haproxy.cfg -c
```

### Obtenir des stats sur l'état de santé des backend
```
echo "show servers state" | socat /var/run/haproxy/admin.sock stdio
```
