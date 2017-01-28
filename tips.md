* [copier coller dans l'espace] [#copier-coller-dans-l'espace)
* [trouver des fichiers dupliqués et les supprimer] (#trouver-des-fichiers-dupliqués-et-les-supprimer)

### Logs en couleurs
```
apt -y  install less ccze
```
```
tailf kern.log | ccze -A | less -R
```
### prendre une identité sans modifier de fichiers

`su - vanrishlog -s /bin/bash`

### dézipper on the fly (sans créer de faichier)
C'est plus écolo 

`gunzip -c syslog.1.gz | less`

### copier coller dans l'espace

http://unix.stackexchange.com/questions/22494/copy-file-to-xclip-and-paste-to-firefox

`alias n3='xclip -selection clipboard -i ~/Bureau/mdpadmin.txt'`

### trouver des fichiers dupliqués et les supprimer
supprime le premier match

`fdupes -rdN  .`
