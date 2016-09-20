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


```
show etherchannel summary
```
### peter la gueule à un port channel

```
conf t 
int po3
no interface port-channel 3
```
