### sur une squeeze, etch

```bash
lvresize --size +1G /dev/mapper/system-usr
resize2fs /dev/mapper/system-usr
```

### étendre un LVM ainsi que le FS en une ligne de commande (à faire à partir de wheezy, sinon on pète le fs)
```
 lvresize --resizefs --size +5G /dev/mapper/systemvm-var_lib_mysql
 ```
### agrandissement d'un vg 

` pvcreate /dev/vdb`

`vgextend systemvm /dev/vdb`

### création d'un snapshot

`lvcreate -L1G -s -n mysnap /dev/system/var_lib_mysql`

