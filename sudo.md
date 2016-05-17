### checker sa conf 

```
visudo -c -f /etc/sudoers.d/elasticsearch 
/etc/sudoers.d/elasticsearch: parsed OK
```

### Dans /etc/sudoers.d/

Il faut supprimer la newline

`cat elasticsearch | tr -d '\n'`

### utiliser les groupes de commandes 

```
# Cmnd alias specification
Cmnd_Alias TAGADA = /usr/sbin/service elasticsearch *, sudoedit /etc/default/elasticsearch, sudoedit /etc/elasticsearch/*, sudoedit /etc/init.d/elasticsearch

elasticsearch ALL=(ALL) TAGADA
```
