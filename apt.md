* [le script de post-remove empêche la suppresion d'un paquet] (#le-script-de-post-remove-empêche-la-suppresion-d'un-paquet)

### Forcer la version backport d'un paquet
Le -t correspond à target release
```
apt-get install haproxy -t jessie-backports
```

### Forcer la version d'un paquet
```
apt-get install  php5-mysql=5.5.30-1~dotdeb+7.1
```
### geler la version d'un paquet
Avec elasticsearch
`echo "elasticsearch hold" | dpkg --set-selections`

On vérifie avec un

```bash
dpkg --get-selections elasticsearch
elasticsearch                                   hold
```
### voir la liste des clés chargées
`apt-key list`

### le script de post-remove empêche la suppresion d'un paquet

allez dans /var/lib/dpkg/info/ puis éditer le script de post-install à problème ex 
util-linux.postinst, y insérer un exit 0 en début de fichier.
relancer le remove.

### virer les paquets rc

https://linuxprograms.wordpress.com/2010/05/12/remove-packages-marked-rc/

### figer des paquets

apt-mark hold "nom du paquet"

### récupérer les fichiers de conf d'un paquet

https://askubuntu.com/questions/66533/how-can-i-restore-configuration-files

```bash
dpkg-deb --fsys-tarfile rspamd_1.8.1-1~stretch_amd64.deb | sudo tar x  -C /tmp/
```
puis fouiller dans /tmp/etc pour y trouver son bonheur. 
