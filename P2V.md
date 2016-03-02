Linux
-----

Les machines à migrer sous Linux doivent être installé avec Grub et non
Lilo. Dans le cas contraire la machine copié ne démarrera pas. Il faut
donc installer Grub et supprimer Lilo de la machine source avant
d'effectuer la migration

Conversion Red Hat 9 avec kernel 2.4
------------------------------------

### Injection

Après avoir créé la VM avec les contraintes suivantes :

-   même taille d'inode
-   même partitionnement, idéalement avec les mêmes options et les mêmes
    LABEL

Puis lancés la copie de la machine source vers la machine cible :

`tar cpf - /* --exclude "proc" --exclude "sys" --exclude "dev" | ssh IP_DISTANTE "(cd /target; tar xpf -)"`

Ou depuis la machine cible:

`ssh IP_DISTANTE "tar cpf - /* --exclude \"proc\" --exclude \"sys\" --exclude \"dev\"" | tar xvf - -C /target;`

### Système et VM

<http://www.1a-centosserver.com/centos_redhat_vmware_virtualization/redhat-linux-7-8-9-vmware-convert-no-operating-system-kernel-panic-solution.php>

-   Sélectionner le contrôleur *SCSI* *Bus Logic* lors de la création de
    la VM

-   et modifier, une fois la VM chargée, le fichier suivant :
```
`cat /etc/modules.conf`\
`alias scsi_hostadapter BusLogic`
```
-   regénérer l'initrd pour prise en compte du nouveau module avec
```
`mkinitrd -v -f /boot/initrd-2.x.y-zz.img 2.x.y-zz`
```
### FS

Si les partitions sont créés et formatées avec un noyau récent,
l'utilisation de ces partitions avec un noyau 2.4 présentera des
problèmes de compatabilité d'option :

On désactive les options
```
`tune2fs -O ^dir_index /dev/sda3`\
`debugfs -w /dev/sda3 -R "features ^resize_inode ^ext_attr"`
```
Solution pour Debian
--------------------

    1.  Créer une vm ou mettre à disposition un serveur physique
    2.  booter sur un liveCD (systemRescue par exemple)
    3.  Créer une table des partitions identique
    3 bis   mettre la première partition bootable 
    4.  formater au même format : mkfs.ext3 / mkswap et cie.. 
    4.bis    vérifier avec un tune2fs -l /dev/mapartion | grep inode que la taille de l'inode est pareil sur les deux machines 
    5.  monter la partition sur le liveCD : /mnt/xxx
    6.  lancer la commande sur la destination : cd /mnt/xxx; nc -l -p $PORT | tar xpf -
    7.  lancer la commande sur la source : cd /; tar cpf - /* --exclude "proc" --exclude "sys" --exclude "dev" | nc $IP_DEST $PORT
    8.  mkdir /dev /sys et /proc
    9.  mount --bind /dev /mnt/$DEST/dev (meme chose pour /proc et /sys
    10. chroot dans le nouvel environnement
    11. grub-install /dev/sda
    12. grub-mkconfig >> boot/grub/grub.conf
    13. Modifier également les UUID dans le fichier dans /etc/fstab 
    14. blkid
    Via SSH :
    tar cpf - /* --exclude "proc" --exclude "sys" --exclude "dev" | ssh IP_DISTANTE "(cd /target; tar xpf -)"
