## sauvegarder un guest xen

```
xm shutdown server1
dd if=/dev/server/server1-disk | bzip2 > /backup/server1-disk.img.bz2 
xm start server1
```

## démarrer un guest
C'est ambigüe, mais il ne faut pas utiliser "start" mais create !!!  
```
Started domain server1
```

