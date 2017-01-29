* [obtenir des infos sur un volume] (#obtenir-des-infos-sur-un-volume)

### obtenir des infos sur un volume

Obtenir le type par exemple :

```
zfs get type  vmpool/data/vm-104-disk-1 
NAME                       PROPERTY  VALUE   SOURCE
vmpool/data/vm-104-disk-1  type      volume  -
```

Obtenir toutes les infos
```
zfs get all  vmpool/data/vm-104-disk-1 
```
