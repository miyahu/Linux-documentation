* [lister les vservers] (#lister-les-vservers)
* [visulaliser les volumes] (#visulaliser-les-volumes)
* [visualiser les acls] (#visualiser-les-acls)
* [visualiser les interfaces] (#visualiser-les-interfaces)

### lister les vservers

```
vserver show
```

### visulaliser les volumes

```
CLUSTERCT01::> volume show nfs1
server   Volume       Aggregate    State      Type       Size  Available Used%
--------- ------------ ------------ ---------- ---- ---------- ---------- -----
mut-ct    nfs1      aggr_01online     RW        600GB    81.81GB   86%
```

* server: correspond au vserver (context)
* volume : nom du volume (share)
* aggregate: disque 

### visualiser les acls

```
vserver export-policy rule show
```
### visualiser les interfaces

```
network interface show
            Logical    Status     Network            Current       Current Is
Vserver     Interface  Admin/Oper Address/Mask       Node          Port    Home
----------- ---------- ---------- ------------------ ------------- ------- ----
CLUSTERCT01
            CLUSTERCT01-01_intercluster 
                         up/up    172.16.5.3/24     CLUSTERCT01-01 
                                                                   e1b-i6   true
```


