### après avoir modifié un service systemd

`systemctl daemon-reload`

### /etc/systemd vs /usr/lib/systemd

* /etc/systemd accueil les services personnaliser

* /usr/lib/systemd accueil les services standard 

### sysctl
La commande 
`sysctl  -p`
ne prend en compte que le fichier sysctl.conf, pour prendre tous les chemins, utilisez
`sysctl --system -p`
