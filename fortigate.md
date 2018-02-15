* [ressources] (#ressource)
* [obtenir le status du cluster] (#obtenir-le-status-du-cluster)
* [accéder au second noeud d'un cluster] (#accéder-au-second-noeud-d'un-cluster)
* [options et terminologie] (#options-et-terminologie)
* [faire un top] (#faire-un-top)
* [faire un ping] (#faire-un-ping)
* [faire une recherche en cli] (#faire-une-recherche-en-cli)
* [exemple de load balancer http] (#exemple-de-load-balancer-http)
* [troubleshooting] (#troubleshooting)
* [comment exclure dans la console de log web] (#comment-exclure-dans-la-console-de-log-web)
* [les tunnels ipsec tombent] (#les-tunnels-ipsec-tombent)
* [configuration des routes statiques] (#configuration-des-routes-statiques)
* [comprendre les vpn events] (#comprendre-les-vpn-events)
* [comprendre le split tunneling] (#comprendre-le-split-tunneling)



### ressources
* https://itsecworks.com/2011/07/18/fortigate-basic-troubleshooting-commands/
* https://www.iphouse.com/debugging-ipsec-vpns-in-fortigate/

https://itsecworks.com/2012/03/22/debugging-fortigate-vpns/

### obtenir le status du cluster

`get system ha status`


### accéder au second noeud d'un cluster

`execute ha manage 0` (ou 1)

### options et terminologie

* hbdev: hearthbeat interfaces

### faire un top

`get system performance top`

### faire un ping

`execute  ping 8.8.8.8`

### faire une recherche en cli

`show | grep -A 3 -B 3  monvserver`

### autoriser l'accès vers une VIP interne

il faut : mettre set match-vip enable 
il faut mettre une règle dédié

### exemple de load balancer http

```
config firewall vip
    edit "VSERVERINTWEBHTTPS"
        set type server-load-balance
        set extip 10.0.34.10
        set extintf "any"
        set server-type https
        set http-ip-header enable
        set ldb-method http-host
        set extport 443
        set monitor "CHECK_HTTP_ROOT_80"
        set ssl-certificate "int.ali.fr"
        config realservers
            edit 1
                set ip 10.0.134.10
                set port 80
                set http-host "int.ali.fr"
            next
        end 
        set http-multiplex enable
    next
end
```
### troubleshooting

http://kb.fortinet.com/kb/viewContent.do?externalId=FD30038

Lister les  gateway IKE (phase 1):

diag vpn ike gateway list

Lister les tunnels (phase 2) :

diag vpn tunnel list

exemple :

diag vpn ike gateway list et récupérer le nom de la phase 1
diag vpn ike log filter name <phase1-name> 
diag debug app ike -1
diag debug enable


### comment exclure dans la console de log web
 
ajouter un ! devant le motif à exclure..

### les tunnels ipsec tombent

http://cookbook.fortinet.com/ipsec-vpn-troubleshooting/

The VPN tunnel goes down frequently.

If your VPN tunnel goes down often, check the Phase 2 settings and either increase the Keylife value or enable Autokey Keep Alive.

http://kb.fortinet.com/kb/documentLink.do?externalID=12069

`set keepalive  enable`

### configuration des routes statiques

`config router static`

### comprendre les vpn events

Astuces: le Cookie permet de suivre les évenements d'une session

### troubleshooting règle fw

```
diagnose sniffer packet any "host 10.255.228.41" 4
```

### comprendre le split tunneling

http://www.internet-computer-security.com/VPN-Guide/VPN-client-tunneling.html

Il s'agit d'une fonction permettant au client VPN d'emprunter le chemin réseau habituel pour tout le trafic qui n'aurait pas comme destination les tunnels VPN 

Pour permettre l'accès à différents réseaux, je pense qu'il faut utiliser plusieurs vpn (phase 1), il me semble difficile d'utiliser plus d'une phase2 
