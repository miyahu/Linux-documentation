* [faire un et logique] (#faire un et logique)

# Grep

#### faire un ET logique

utiliser l'option -e plusieurs fois

```bash
netstat -lntp | grep -e bacula -e zabbix
tcp        0      0 10.0.16.1:9102          0.0.0.0:*               LISTEN      2738/bacula-fd  
tcp        0      0 0.0.0.0:10050           0.0.0.0:*               LISTEN      2808/zabbix_agentd
tcp6       0      0 :::10050                :::*                    LISTEN      2808/zabbix_agentd
```

#### compter le nombre d'occurences

```bash
netstat -lntp | grep -e bacula -e zabbix
grep -c tagada /tmp/pouet
2
```
