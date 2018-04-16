# knot

## pilotage

### knsupdate

```bash
apt install knot-dnsutils 
```

Exemple for man page

knsupdate

server 172.17.0.1 5353
zone unigo.fr
origin architux.com
ttl 3600
add test1.example.com. 7200 A 192.168.2.2
show
send
quit

 update failed with error 'NOTAUTH'
