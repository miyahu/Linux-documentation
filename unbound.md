# unbound

## configuration 

### nettoyage de la configuration

```bash 
grep -Ev "^[[:space:]]*#|^$" unbound.conf > unbound.conf-clean
```

### configuration pour forwarder au travers d'un tunnel tcp 

l'idée est que 10.3.3.5 ne puisse être intérrogé qu'en tcp

```bash 
server:
 do-tcp: yes
 tcp-upstream: yes
 incoming-num-tcp: 10
 outgoing-num-tcp: 10

forward-zone:
        name: "lan.amoua.com"
        forward-addr: 10.3.3.5

forward-zone:
    name: "*"
    forward-addr: 10.2.31.10
    forward-addr: 10.2.31.11
```

### Unbound sous Docker 

 docker run --name myunbound -d -p 53:53/udp -v /etc/unbound/unbound.conf.d/unbound.conf:/opt/unbound/etc/unbound/unbound.conf --restart=always mvance/unbound:latest
