### checker sa conf 

```
visudo -c -f /etc/sudoers.d/elasticsearch 
/etc/sudoers.d/elasticsearch: parsed OK
```

### Dans /etc/sudoers.d/

Il faut supprimer la newline

`cat elasticsearch | tr -d '\n'`
