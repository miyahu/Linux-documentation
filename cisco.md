* [ajouter un vlan à un trunk existant](#ajouter-un-vlan-a-un-trunk-existant)
* [trouver les informations de connexion au switch à partir d'un serveur](#trouver-les-informations-de-connexion-au-switch-a partir-d-un-serveur)
* [trouver quelle mac est associée à un port] (#trouver-quelle-mac-est-associée-à-un-port) 
* [mettre en place un port channel] (#mettre-en-place-un-port-channel)
* [péter la gueule à un port channel] (#péter-la-gueule-à-un-port-channel)
* [troubleshooting de po] (#troubleshooting-de-po)
* [ajout de vlan] (#[ajout-de-vlan) 


### passer un port en trunk

retirer 
```bash
switchport mode access
```
ajouter
```bash
switchport mode trunk
```


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

### péter la gueule à un port channel

```
conf t 
int po3
no interface port-channel 3
```

### troubleshooting de po

```
Group: 3 
----------
Group state = L2 
Ports: 2   Maxports = 16
Port-channels: 1 Max Port-channels = 16
Protocol:   LACP
Minimum Links: 0
        Ports in the group:
        -------------------
Port: Gi0/13
------------

Port state    = Up Mstr Assoc In-Bndl 
Channel group = 3           Mode = Active          Gcchange = -
Port-channel  = Po3         GC   =   -             Pseudo port-channel = Po3
Port index    = 0           Load = 0x00            Protocol =   LACP

Flags:  S - Device is sending Slow LACPDUs   F - Device is sending fast LACPDUs.
        A - Device is in active mode.        P - Device is in passive mode.

Local information:
                            LACP port     Admin     Oper    Port        Port
Port      Flags   State     Priority      Key       Key     Number      State
Gi0/13    SA      bndl      32768         0x3       0x3     0x10E       0x3D  

Partner's information:

                  LACP port                        Admin  Oper   Port    Port
Port      Flags   Priority  Dev ID          Age    key    Key    Number  State
Gi0/13    SA      255       001e.c9b2.3e5b  15s    0x0    0x11   0x2     0x3D  

Age of the port in the current state: 0d:00h:10m:41s

Port: Gi0/28
------------

Port state    = Up Mstr Assoc In-Bndl 
Channel group = 3           Mode = Active          Gcchange = -
Port-channel  = Po3         GC   =   -             Pseudo port-channel = Po3
Port index    = 0           Load = 0x00            Protocol =   LACP

Flags:  S - Device is sending Slow LACPDUs   F - Device is sending fast LACPDUs.
        A - Device is in active mode.        P - Device is in passive mode.

Local information:
                            LACP port     Admin     Oper    Port        Port
Port      Flags   State     Priority      Key       Key     Number      State
Gi0/28    SA      bndl      32768         0x3       0x3     0x11D       0x3D  

Partner's information:

                  LACP port                        Admin  Oper   Port    Port
Port      Flags   Priority  Dev ID          Age    key    Key    Number  State
Gi0/28    SA      255       001e.c9b2.3e5b  23s    0x0    0x11   0x1     0x3D  

Age of the port in the current state: 0d:00h:10m:41s

        Port-channels in the group: 
        ---------------------------

Port-channel: Po3    (Primary Aggregator)

------------

Age of the Port-channel   = 0d:00h:17m:06s
Logical slot/port   = 2/3          Number of ports = 2
HotStandBy port = null 
Port state          = Port-channel Ag-Inuse 
Protocol            =   LACP
Port security       = Disabled

Ports in the Port-channel: 

Index   Load   Port     EC state        No of bits
------+------+------+------------------+-----------
  0     00     Gi0/13   Active             0
  0     00     Gi0/28   Active             0

Time since last port bundled:    0d:00h:11m:48s    Gi0/28
Time since last port Un-bundled: 0d:00h:12m:02s    Gi0/13
```

### ajout de vlan
Pour le vlan 101 par exemple
```
conf t
vlan 101
name "description"
```

