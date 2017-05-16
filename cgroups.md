* [visualiser l'usage des control groups] (#visualiser-l'usage-des-control-groups)
* [limiter le nombre de processus avec systemd] (#limiter-le-nombre-de-processus-avec-systemd)
* [exemple d'allocations dynamique] (#exemple-d'allocations-dynamique)
* [cgconfig] (#cgconfig)

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
