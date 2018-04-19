# lvm

http://www.datadisk.co.uk/html_docs/redhat/rh_lvm.htm


### sur une squeeze, etch

```bash
lvresize --size +1G /dev/mapper/system-usr
resize2fs /dev/mapper/system-usr
```

### étendre un LVM ainsi que le FS en une ligne de commande (à faire à partir de wheezy, sinon on pète le fs)

```bash
 lvresize --resizefs --size +5G /dev/mapper/systemvm-var_lib_mysql
 ```
### agrandissement d'un vg 

` pvcreate /dev/vdb`

`vgextend systemvm /dev/vdb`

### création d'un snapshot

`lvcreate -L1G -s -n mysnap /dev/system/var_lib_mysql`

### suppression d'un lv

```bash
lvmremove /dev/data/monsnap
```

### lvs attributes

https://www.unixarena.com/2013/08/redhat-linux-lvm-volume-attributes.html


mwi-aom-- : mirrored, write, Allocation policy inherited, active, open, 
iwi-aom-- : mirror image, write, Allocation policy inherited, active, open, 

* o : au fait que le périphérique soit ouvert (partition utilisée)
* x : périphérique exporté

### clonage lvm 

http://www.voleg.info/lvm2-clone-logical-volume.html

opération assez longue

on le passe du type linéaire vers le type mirroir

 lvconvert --type mirror --alloc anywhere -m1 /dev/rootvg/test

* --type mirror (je pense que cela fait doublon avec ci-dessous)
* -m 1 : type de mirroir (raid 1 ici)
* --alloc anywhere : avec cela, je pense que l'on demande s'allouer les extends nécessaire, il créera donc un clone du disque 

après l'opération, voici ce qui apparaît 

```bash
lvs -a -o +devices  | grep antonio
  antonio1            vm   mwi-aom---  50.00g                                antonio1_mlog 100.00           antonio1_mimage_0(0),antonio1_mimage_1(0)
  [antonio1_mimage_0] vm   iwi-aom---  50.00g                                                               /dev/sda5(288000)                        
  [antonio1_mimage_1] vm   iwi-aom---  50.00g                                                               /dev/sda5(300800)                        
  [antonio1_mlog]     vm   lwa-aom---   4.00m
```
on peut voir en première ligne que le LV "antonio1" se base sur 2 LV : antonio1_mimage_0 et antonio1_mimage_1

lvconvert --splitmirrors 1 --name "nom du doublon" /dev/rootvg/test


