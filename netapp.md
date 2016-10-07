* [lister les vservers] (#lister-les-vservers)
* [visulaliser les volumes] (#visulaliser-les-volumes)
* [visualiser les acls] (#visualiser-les-acls)
* [visualiser les interfaces] (#visualiser-les-interfaces)
* [voir les connexions activent] (#voir-les-connexions-activent)
* [voir les connexions activent par interface] (#voir-les-connexions-activent-par-interface)
* [visualiser la policy d'un volume] (#visualiser-la-policy-d'un-volume)

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

### voir les connexions activent

```
show-clients
Node            Vserver Name    Client IP Address  Count
--------------  --------------  -----------------  ------
CLUSTERCT01-01
                mut-c          10.0.1.11               1
                mut-c          10.0.1.12               1
```

### voir les connexions activent par interface

```
network connections active show-lifs
Node            Vserver Name    Interface Name    Count
--------------  --------------  ----------------  ------
CLUSTERCT01-02
                mut-c          ni_lif0_308           9
                mut-c          of_lif0_284           5
                mut-c          otc_276              14
```

### visualiser la policy d'un volume

```
CLUSTERCT01::volume> show -vserver pris-ct -volume pnfs1 -fields policy
vserver   volume  policy     
--------- ------- ---------- 
pris-ct pnfs1 pris-ct0
```
