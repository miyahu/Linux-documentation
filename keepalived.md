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

### théorie

#### real_server vs sorry_server
Le sorry_server n'est utilisé qu'en cas de perte de tous les real_servers, il travaille donc avec ce derniers en mode actif/passif.
Le sorry_server ne devrait présenter qu'une page de maintenance, la ventilation des requêtes ne devant se faire que sur les real_servers.

Utiliser un real_server comme sorry_server est assez bête, car ne noeud n'est pratiquement jamais déclenché ...

Si l'on veut utiliser une ferme avec des membres actif/passif, utiliser plutôt wrr avec une grosse différence de poids par exemple. 

#### modes de travail

deux modes possibles :
* vrrp : avec HA de VIP
* virtual server : avec NAT et VIP

Et les deux sont mixés chez AWM 


#### rafraichissement des adresses mac 

Deux solutions :
* arping vers les serveurs
* vmac pour le partage de mac !!!

#### routage des requête avec fwmark
Cas d'utilisations :
* router certains blocs d'IP vers un serveur spécifique ex chinois
* rediriger une IP attaquante vers une page de maintenance

#### quelques options 

##### delay loop

# L'etat de santé des real_servers est vérifié toutes les 5 secondes

`delay_loop 5`

##### nopreempt

(from linux maganzine)

nopreempt permet d'empêcher la bascule vers le maître par défaut en cas de retour à la normale de celui-ci.

##### lb_algo


* rr = round robin
* wrr = weighted round robin
* lc = least connection (I like this one the best!)
* wlc = weighted least connection scheduling>
* sh = shortest expected delay
* dh = destination hashing
* lblc = locality based least connection


