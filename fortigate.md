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



### ressources
* https://itsecworks.com/2011/07/18/fortigate-basic-troubleshooting-commands/
* https://www.iphouse.com/debugging-ipsec-vpns-in-fortigate/

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

Si la VIP est sur LAN1

#il faut autoriser les connections venant de LAN1 à aller sur LAN1 vers la VIP
#Puis autoriser les connections de LAN2 vers LAN1 vers la VIP

en vérité il faut : mettre set match-vip enable 


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

### comment exclure dans la console de log web
 
ajouter un ! devant le motif à exclure..
