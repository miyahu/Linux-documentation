### Logs en couleurs
```
apt -y  install less ccze
```
```
tailf kern.log | ccze -A | less -R
```
### prendre une identité sans modifier de fichiers

`su - vanrishlog -s /bin/bash`
