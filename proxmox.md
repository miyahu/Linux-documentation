* [quitter minicom](#quitter minicom)
* [convertir un disque raw en qcow](#convertir-un-disque-raw-en-qcow)   
* [monter un qcow](#monter-un-qcow) 
* [créer un container](#créer-un-container) 
* [ajouter une interface à un container](#ajouter-une-interface-à-un-container) 
* [Mettre son container sur Internet](#mettre-son-container-sur-internet) 

### rediriger tous les ports VNC d'une  VM vers un port unique

https://pve.proxmox.com/wiki/Vnc_2.0

### Sur mox lors d'une erreur d'installation, pour recommancer il faut

1. supprimer la VM sur foreman
2. supprimer la VM sur proxmox : qm stop id && qm destroy id

### message suivant 
`
TASK [mox : Remove volatile proxmox API and Forman API auth conf file] *********
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: AttributeError: 'list' object has no attribute 'startswith'
fatal: [localhost]: FAILED! => {"changed": false, "failed": true, "parsed": false}
`

Il y a un doublon, par exemple que proxmox qui répond au même nom

### status du cluster

`pvecm status`

### générer une nouvelle conf réseau pour une VM

`qm set 564 --net0 virtio,bridge=vmbr229,rate=1000`

### savoir ou se trouve une VM
Sur n'impporte quel node du cluster 

`connect_VM --show-all`


### ajout de disque en CLI

 version 3.3
 
 attention, proxmox en version 3.3 nous oblige à utiliser qm monitor pour présenter les nouveaux devices aux guests

`qemu-img create -f qcow2 -o preallocation=metadata vm-296-disk-3.qcow2 50G`

`qm monitor <vm_id>̀

`drive_add 0 file=/VMs/images/<vm_id>/vm-<vm_id>-disk-3.qcow2,format=qcow2,id=drive-virtio-disk2,if=none`
`device_add virtio-blk-pci,scsi=on,drive=drive-virtio-disk2`

Ajouter :

`virtio2: VMs_prphyp2:<vm_id>/vm-<vm_id>-disk-3.qcow2,format=qcow2`

à

`/etc/pve/qemu-server/<vm_id>.conf`

## quitter minicom
Ctrl+a & a+q

## convertir un disque raw en qcow

`qemu-img convert -p -O qcow2 /dev/mapper/VG_VMs_SSD-vm--113--disk--1 vm--113--disk--1.qcow2̀

## monter un qcow

http://www.randomhacks.co.uk/how-to-mount-a-qcow2-disk-image-on-ubuntu/

`qemu-nbd --connect=/dev/nbd0 /VMs/images/112/vm-112-disk-0.qcow2`

On vérifie son partitionnement
``` 
fdisk -l /dev/nbd0 

Disque /dev/nbd0 : 50 GiB, 53687091200 octets, 104857600 secteurs
Unités : secteur de 1 × 512 = 512 octets
Taille de secteur (logique / physique) : 512 octets / 512 octets
taille d'E/S (minimale / optimale) : 512 octets / 512 octets
Type d'étiquette de disque : dos
Identifiant de disque : 0x832ab2b5

Device      Boot   Start       End   Sectors  Size Id Type
/dev/nbd0p1 *       2048    999423    997376  487M 83 Linux
/dev/nbd0p2      1001470 104855551 103854082 49,5G  5 Extended
/dev/nbd0p5      1001472   7000063   5998592  2,9G 83 Linux
/dev/nbd0p6      7002112 104855551  97853440 46,7G 8e Linux LVM
```
Enfin on monte la partition qui nous intéresse

`mount /dev/nbd0p5 /media/̀

et enfin déconnecter le périphérique nbd0

`qemu-nbd --disconnect /dev/nbd0̀

## créer un container

```
pct create 102 /var/lib/vz/template/cache/debian-8.0-standard_8.4-1_amd64.tar.gz -password
```

## ajouter une interface à un container
```
pct set 100 -net0 name=eth0,bridge=vmbr0,ip=192.168.15.147/24,gw=192.168.15.1
```

## mettre son container sur internet

Ajouter cela dans le fichier interface
```
auto vmbr1
iface vmbr1 inet static
        address  10.10.0.1/24
        bridge_ports eth1
        bridge_stp off
        bridge_fd 0
```
Puis

```
iptables -t nat -A POSTROUTING -o vmbr0 -j SNAT --to-source 163.172.217.110
apt-get install iptables-persistent
```



