* [ressources] (#ressource)
* [obtenir le status du cluster] (#obtenir-le-status-du-cluster)
* [accéder au second noeud d'un cluster] (#accéder-au-second-noeud-d'un-cluster)
* [options et terminologie] (#options-et-terminologie)
* [faire un top] (#faire-un-top)
* [faire un ping] (#faire-un-ping)
* [faire une recherche en cli] (#faire-une-recherche-en-cli)

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

il faut autoriser les connections venant de LAN1 à aller sur LAN1 vers la VIP
Puis autoriser les connections de LAN2 vers LAN1 vers la VIP
