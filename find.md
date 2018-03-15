# find

## uses case

### trouve les logs non compressés

`find . -regextype posix-egrep -regex ".*\.log(\.[1-9])?$"` 

### supprimmer les fichiers modifiés en 2017

```bash
find . -type f -newermt 20170110 -not -newermt 20180101 -delete
```

### détails sur le mtime

+1 plus vieux d'au moins un jour
-1 pas plus vieux d'un jour  
