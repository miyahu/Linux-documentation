
* [obtenir son ip externe] (#obtenir-son-ip-externe)
* [tunnel gre sur Debian](#tunnel-gre-sur-Debian)
* [récupérer l'adresse mac d'une interface] (#récupérer-l'adresse-mac-d'une-interface)
* [voir les vlan chargés par interface] (#voir-les-vlan-chargés-par-interface)

## tunnel gre sur Debian
```
auto gre0
        iface gre0 inet static
        address 10.10.2.20/24  # extremité interne local du tunnel
        pre-up ip tunnel add gre0 mode gre remote 164.172.213.191 local 166.172.117.10 # extremité externe local et distance du tunnel
        pre-up ip link set gre0 multicast on
        post-down ip tunnel del gre1
```

## récupérer l'adresse mac d'une interface
```
ethtool -P eth3
```

## voir les vlan chargés par interface

```
cat /proc/net/vlan/config
VLAN Dev name    | VLAN ID
Name-Type: VLAN_NAME_TYPE_RAW_PLUS_VID_NO_PAD
bond0.61       | 61  | bond0
bond0.216      | 216  | bond0
bond0.355      | 355  | bond0
bond0.356      | 356  | bond0 
```
## obtenir son ip externe

```
curl 'https://api.ipify.org?format=txt'
```
