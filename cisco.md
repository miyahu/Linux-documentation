* [ajouter un vlan à uin trunk existant](#ajouter-un-vlan-a-un-trunk-existant)
* [trouver les informations de connexion au switch à partir d'un serveur](#trouver-les-informations-de-connexion-au-switch-a partir-d-un-serveur)
* [trouver quelle mac est associée à un port] (#trouver-quelle-mac-est-associée-à-un-port) 
* [mettre en place un port channel] (#mettre-en-place-un-port-channel)
* [peter la gueule à un port channel] (#peter-la-gueule-à-un-port-channel)

### trouver les informations de connexion au switch à partir d'un serveur

`/var/cache/cdpr/switch.info`


### ajouter un vlan à un trunk existant)

`switchport trunk allowed vlan add 355̀


### trouver quelle mac est associée à un port

récupérer la mac 
```
ip link show dev eth2

1c:98:ec:19:31:46

```

Se mettre sur le serveur, activer l'interface et faire un ping
```
ifconfig eth2 up && ping -I eth2 google.fr
```
Chercher la mac sur le switch
```
show mac address-table | inc 3146
```

### mettre en place un port channel

Voir la conf 
```
show etherchannel summary
```

exemple concret :

Pour les ports
```
show run int Gi1/15
Building configuration...

Current configuration : 359 bytes
!
interface GigabitEthernet1/15
 description hyp3:eth0
 switchport access vlan 254
 switchport trunk encapsulation dot1q
 switchport trunk native vlan 254
 switchport trunk allowed vlan 61,254
 switchport mode trunk
 switchport nonegotiate
 channel-group 3 mode active
 spanning-tree portfast
 spanning-tree bpduguard enable
 spanning-tree guard root
end
```

pour le po
```
show run int po3
Building configuration...

Current configuration : 270 bytes
!
interface Port-channel3
 description hyp3 via Gi1/15 et Gi1/16
 switchport
 switchport access vlan 254
 switchport trunk encapsulation dot1q
 switchport trunk native vlan 254
 switchport trunk allowed vlan 61,254
 switchport mode trunk
 switchport nonegotiate
end
```

Côté Linux

```
auto bond0
iface bond0 inet manual
    slaves eth0 eth1
    bond_mode 4
    bond-xmit-hash-policy layer3+4
    bond_miimon 100
    bond_downdelay 200
    bond_updelay 200
    bond-lacp-rate fast
```

On vérifie le status

```
cat /proc/net/bonding/bond0
Down Delay (ms): 200

802.3ad info
LACP rate: fast
Min links: 0
Aggregator selection policy (ad_select): stable
System priority: 65535
System MAC address: 1c:98:ec:19:31:44
Active Aggregator Info:
        Aggregator ID: 1
        Number of ports: 2
        Actor Key: 9
        Partner Key: 3
        Partner Mac Address: 00:1e:7a:56:16:c0

Slave Interface: eth0
MII Status: up
Speed: 1000 Mbps
Duplex: full
Link Failure Count: 0
Permanent HW addr: 1c:98:ec:19:31:44
Slave queue ID: 0
Aggregator ID: 1
Actor Churn State: none
Partner Churn State: none
Actor Churned Count: 0
Partner Churned Count: 1
details actor lacp pdu:
    system priority: 65535
    system mac address: 1c:98:ec:19:31:44
    port key: 9
    port priority: 255
    port number: 1
    port state: 63
details partner lacp pdu:
    system priority: 32768
    system mac address: 00:1e:7a:56:16:c0
    oper key: 3
    port priority: 32768
    port number: 16
    port state: 61
...
```



### peter la gueule à un port channel

```
conf t 
int po3
no interface port-channel 3
```
