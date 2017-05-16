* [visualiser l'usage des control groups] (#visualiser-l'usage-des-control-groups)
* [limiter le nombre de processus avec systemd] (#limiter-le-nombre-de-processus-avec-systemd)
* [exemple d'allocations dynamique] (#exemple-d'allocations-dynamique)
* [cgconfig] (#cgconfig)
* [les limites dans systemd] (#les-limites-dans-systemd)
* [lister les groupes] (#lister-les-groupes)
* [visualiser les paramètres d'un groupe] (#visualiser-les-paramètres-d'un-groupe)

### visualiser l'usage des control groups 
```
systemd-cgtop
```

### limiter le nombre de processus avec systemd
Pour munin-node par exemple 

```
cat /etc/systemd/system/multi-user.target.wants/munin-node.service
[Unit]
Description=Munin Node
Documentation=man:munin-node(1) http://munin.readthedocs.org/en/stable-2.0/reference/munin-node.html

[Service]
EnvironmentFile=-/etc/default/munin-node
Type=forking
Restart=always
ExecStart=/usr/sbin/munin-node $DAEMON_ARGS
PIDFile=/run/munin/munin-node.pid
LimitNPROC=2

[Install]
WantedBy=multi-user.target
```
Puis rechargement

```
systemctl daemon-reload
```
Puis reload
```
systemctl restart munin-node
```

### cgconfig

```
group muninlimited {
        perm {  
                task {  
                        uid = munin;
                        gid = munin;
                }
                admin { 
                        uid = munin;
                        gid = munin;
                }
        }   
        cpu {   
                cpu.shares = 101;
        }
        blkio { 
                blkio.throttle.read_bps_device = "202:2         20971520";
                blkio.throttle.write_bps_device = "202:2         10485760";
        }       
}
```

### exemple d'allocations dynamique

```
cgset -r cpu.shares=512  muninlimited
```

### daemoniser le tous

```
apt install cgroup-tools
```

#### Configuration du service

Venant de https://forum.dug.net.pl/viewtopic.php?pid=299664

```
cat > /etc/systemd/system/cgrulesengd.service <<EOF
[Unit]
Description=CGroup Rules Engine
Documentation=man:cgrulesengd
ConditionPathIsReadWrite=/etc/cgrules.conf
DefaultDependencies=no
Requires=cgconfig.service
Before=basic.target shutdown.target
After=local-fs.target cgconfig.service
Conflicts=shutdown.target

[Service]
Type=simple
ExecStart=/usr/sbin/cgrulesengd -n -Q

[Install]
WantedBy=sysinit.target
EOF
```

#### Activation et démarrage

```
systemctl enable cgrulesengd
systemctl enable cgrulesengd
```

### les limites dans systemd

de https://forum.dug.net.pl/viewtopic.php?pid=299664

```
Nice=
IOSchedulingClass=
IOSchedulingPriority=
CPUShares=
StartupCPUShares=
TasksMax=
MemoryLimit=
BlockIOWeight=
OOMScoreAdjust=
```

### lister les groupes

```
cgutil tree
/
   +system.slice
   |   `cgconfig.service
   `muninlimited
```

### visualiser les paramètres d'un groupe

```
cgget -a /muninlimited
/muninlimited:
cpu.shares: 800
cpuacct.usage_percpu: 23934238891739 20729344018147 19515163339508 18385692525500
cpuacct.stat: user 7297755
        system 890094
cpuacct.usage: 82564438774894
blkio.throttle.io_serviced: 202:3 Read 9
        202:3 Write 0
        202:3 Sync 0
        202:3 Async 9
        202:3 Total 9
        202:2 Read 70266
        202:2 Write 80
        202:2 Sync 80
        202:2 Async 70266
        202:2 Total 70346
        Total 70355
...
```
