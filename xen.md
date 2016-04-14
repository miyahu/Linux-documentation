## sauvegarder un guest xen

```
xm shutdown server1
dd if=/dev/server/server1-disk | bzip2 > /backup/server1-disk.img.bz2 
xm start server1
```

