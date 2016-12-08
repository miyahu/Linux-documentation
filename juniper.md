* [retour arrière sur une modif avant commit](#retour-arrière-sur-une-modif-avant-commit)

### retour arrière sur une modif avant commit

Pour connaitre les modifs en attente

`show | compare`

pour supprimer les pending commit 

`rollback 0`

### ajout de vlan sur port

* passer en *configure*
* puiis afficher son port

```
show interfaces ae42 unit 0 
family ethernet-switching {
    port-mode trunk;
    vlan {
        members [ 230 vlan100 ];
    }
    native-vlan-id 3;
}
```

```
set interfaces ae42 unit 0 family ethernet-switching vlan members [ 230 vlan100 vlan207 ]
```
puis commit

``
commit
```
