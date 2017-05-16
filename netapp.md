* [lister les vservers] (#lister-les-vservers)
* [visulaliser les volumes] (#visulaliser-les-volumes)
* [visualiser les acls] (#visualiser-les-acls)
* [visualiser les interfaces] (#visualiser-les-interfaces)
* [voir les connexions activent] (#voir-les-connexions-activent)
* [voir les connexions activent par interface] (#voir-les-connexions-activent-par-interface)
* [visualiser la policy d'un volume] (#visualiser-la-policy-d'un-volume)
* [trouver l'ip du client associée à un volume] (#trouver-l'ip-du-client-associée-à-un-volume)
* [voir les montages côté netapp] (#voir-les-montages-côté-netapp)
* [remonter l'arborescence] (#remonter-l'arborescence)

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

### trouver l'ip du client associée à un volume 

L'ip n'est pas associé à un *volume*, juste à une *lif*

il faut chercher, avec comme clé, le nom de la *lif*

```
network connections active show -vserver mut-ct -remote-ip 10.0.16*
Vserver    Interface              Remote
Name       Name:Local Port        Host:Port                    Protocol/Service
---------- ---------------------- ---------------------------- ----------------
Node: CLUSTERCT04-04
mut-ct     riv_lif0_37:2049      10.0.16.14:1002             TCP/nfs
```

### voir les montages côté netapp

Junction Path

```
volume show -vserver prisa-ct  -junction                           
                                Junction                            Junction
Vserver   Volume       Language Active    Junction Path             Path Source
--------- ------------ -------- --------  ------------------------- -----------
prisa-ct pmnfs1   fr.UTF-8 true      /vol/pmnfs1           RW_volume
```

### remonter l'arborescence

utiliser *.."

### voir les junction path

CLUSTERCT01::> volume show -vserver mut-cl -volume cls* -junction
```
                                Junction                            Junction
Vserver   Volume       Language Active    Junction Path             Path Source
--------- ------------ -------- --------  ------------------------- -----------
mut-cl    clsnfs1   fr.UTF-8 true      /vol/clsnfs1           RW_volume
```

### snapmirror

vérifier le status des snapmirrors

```
snapmirror show
```
Le status effectif ne doit apparaître que sur le replica

Utilisez aussi 

```
snapmirror show-history
```

###  Error: command failed: Failed to create or determine if a junction exists within volume "mutep_root". Error occurred with the remaining junction path of "/vol/.." for the given path of "/vol/.." Reason: Junction create failed (2)

Il faut créer le volume /vol avec
```
qtree create -vserver mut-ep -qtree vol -volume mutep_root
```
