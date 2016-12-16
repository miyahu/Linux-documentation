* [dumper le trafic d'un socket unix] (#dumper-le-trafic-d'un-socket-unix)

### dumper le trafic d'un socket unix
```
mv /var/run/www.sock{,.orig}
socat -t100 -x -v UNIX-LISTEN:/var/run/www.sock,mode=777,reuseaddr,fork UNIX-CONNECT:/var/run/www.sock.orig &> /tmp/pouet &
time curl  -v localhost:8080/test.php
```
