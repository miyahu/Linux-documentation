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

```bash
netstat -an|grep ":443"|awk '/tcp/ {print $6}'|sort -nr| uniq -c
```

### exclure un répertoire des copies

```bash
cp -av /opt/sshgate/!(logs) /var/backups/
```

### strace de multiples PID

```bash
pgrep  php-fpm |sed 's/\([0-9]*\)/\-p \1/g' | sed ':a;N;$!ba;s/\n/ /g'
```

### trouver tous les fichiers manquant avec strace et awk entre deux serveurs

```bash
# strace
strace -v -f -t -s5000 -o /tmp/out -p $(pgrep monprocess) 
# récupération des fichiers non existants
awk -F '"' '/stat/ && /ENOENT/ {print$2}' /tmp/out > /tmp/filelist.txt
# suppression des lignes vides
sed -i '/^$/d' /tmp/filelist.txt 
# on balance sur un autre serveur et on test
while read line ; do readlink $line && echo "Line: $line ok" ; done < /tmp/filelist.txt
```

### tree, exclure des éléments de l'arborescence 

```bash
tree -I static -I "exampleSite|images|static|modules|scss"  themes/light-hugo/
themes/light-hugo/
├── archetypes
│   └── default.md
├── build.sh
├── layouts
│   ├── 404.html
│   ├── _default
│   │   ├── list.html
│   │   └── single.html
│   ├── index.html
│   ├── pages
│   │   └── single.html
│   ├── partials
│   │   ├── footer.html
│   │   ├── foot.html
│   │   ├── header.html
│   │   └── head.html
│   └── post
│       ├── single.html
│       └── summary.html
├── LICENSE
├── README.md
└── theme.toml

6 directories, 16 files
```

### afficher directement les attributs d'un utilisateur ou groupe

```bash
getent passwd ronron
```

