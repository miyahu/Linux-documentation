* [copier coller dans l'espace] [#copier-coller-dans-l'espace)
* [trouver des fichiers dupliqués et les supprimer] (#trouver-des-fichiers-dupliqués-et-les-supprimer)
* [effectuer un diaporama d'images] (#[effectuer-un-diaporama-d'images)
* [renommage en masse] (#renommage-en-masse)

### Logs en couleurs
```
apt -y  install less ccze
```
```
tailf kern.log | ccze -A | less -R
```
### prendre une identité sans modifier de fichiers

`su - varnishlog -s /bin/bash`

### dézipper on the fly (sans créer de faichier)
C'est plus écolo 

`gunzip -c syslog.1.gz | less`

### copier coller dans l'espace

http://unix.stackexchange.com/questions/22494/copy-file-to-xclip-and-paste-to-firefox

`alias mdp='xclip -selection clipboard -i ~/Bureau/mdpadmin.txt'`

### trouver des fichiers dupliqués et les supprimer
prompt avant suppression

`fdupes -rdf  .`

### effectuer un diaporama d'images

`feh --auto-zoom --scale-down -Z -D 5 images/*.png`

### renommage en masse

Pour des divx
```
rename -n 's/\[(\s+)?www\.Cpasbien\.\w+(\s+)\]//' *
```

#### suppression du première espace

```
rename -v 's/^\s+//' * 
```

#### remplacement des espaces par un point
```
 rename -v 's/\s/\./g'
```

#### rempalcement de .. et .-. par un point
```
rename -v 's/\.-\.|\.\./-/g' *
```

#### changement de casse
```
rename -v 'y/A-Z/a-z/' * 
```
### beaucoup d'inode partition 


### Apache

#### trouver les logs en fonction de la date et du code retour

je recherche un code 50* en date du 14/08
```
awk '$10 ~ 50 && $5 ~ "14/Aug/2017" {print}'  other_vhosts_access.log 
```

### l'état des sockets pour un port donné

```
netstat -an|grep ":443"|awk '/tcp/ {print $6}'|sort -nr| uniq -c
```

### exclure un répertoire des copies

```
cp -av /opt/sshgate/!(logs) /var/backups/
```
