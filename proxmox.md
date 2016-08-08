* [quitter minicom](#quitter minicom)

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


#### ajout de disque en CLI

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
