* [disséquer son initrd] (#disséquer-son- initrd)

exemple, je veux activer les volumes groupes inconnus, pour cela je vais ajouter vgchanges -ay à /usr/share/initramfs-tools/scripts/local-top/lvm2 puis
je vais regénérer un initrd avec un mkinitramfs -o /boot/initrd.img-4.4.19-1-pve.

maintenant, je veux savoir si mon initrd buildé le contient bien.

En vrac

```
cp -v /boot/initrd.img-2.6.32-46-pve /tmp/ 
cd /tmp/
mv initrd.img-2.6.32-46-pve{,.gz}
gunzip -v initrd.img-2.6.32-46-pve.gz 
cpio -i < initrd.img-2.6.32-46-pve
vim ./scripts/local-top/lvm2
```
