* [dr et vip] (#dr-et-vip)
* [connaitre les connexions actives] (#connaitre-les-connexions-actives)

### suivre les sessions

```
ipvsadm -Ln | head -n 6
IP Virtual Server version 1.2.1 (size=4096)
Prot LocalAddress:Port Scheduler Flags
  -> RemoteAddress:Port           Forward Weight ActiveConn InActConn
TCP  10.0.30.60:25 rr
  -> 10.0.30.30:25                Route   1      1          595       
  -> 10.0.30.64:25                Route   1      1          595
```  

### suivre une session
```  
ipvsadm -L -n --stats -t  89.31.147.4:8282 
Prot LocalAddress:Port               Conns   InPkts  OutPkts  InBytes OutBytes
  -> RemoteAddress:Port
TCP  89.31.147.4:8282                   95      447      384    49453    38830
  -> 10.0.153.42:82                     95      447      384    49453    38830
```  

### dr et vip

Si l'on fait le choix du *direct routing*, il faut déclarer la VIP sur chaque *real server* :
En  *direct routing*, la requête transit via le LVS ; par contre, le real server répond directement au client.
Il faut donc que le *real server* __*porte*__ la VIP, pour cela nous utiliserons l'adresse *loopback*.


Contenu de /etc/network/interfaces

On défini un scope host et un masque 32 pour ne pas créer de problème
```  
auto lo:dr
iface lo:dr inet static
  address 10.0.0.240/32
  scope host
```  
http://kb.linuxvirtualserver.org/wiki/Using_arp_announce/arp_ignore_to_disable_ARP

dans systctl
```  
net.ipv4.conf.eth0.arp_ignore = 1
net.ipv4.conf.eth0.arp_announce = 2
```  
Contrôle côté LVS
```  
ipvsadm -Ln -t 10.0.0.240:8130
Prot LocalAddress:Port Scheduler Flags
  -> RemoteAddress:Port           Forward Weight ActiveConn InActConn
TCP  10.0.0.240:8130 wlc
  -> 10.0.0.241:8130              Route   3      0          1         
  -> 10.0.0.242:8130              Route   3      0          1         
  -> 10.0.0.243:8130              Route   3      0          1
```  
* route correspond à *direct routing*

### connaitre les connexions actives

```  
ipvsadm -L -n --connection
```  
