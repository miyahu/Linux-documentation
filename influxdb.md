* [un peu de théorie] (#un peu de théorie)
* [obtenir le nom des métriques](#obtenir-le-nom-des-métriques)
* [obtenir le nom des séries stocké](#obtenir-le-nom-des-séries-stockés)
* [exemple de requêtes](#exemple-de-requêtes)
* [exemple de requêtes en select](#exemple-de-requêtes-en-select)
* [supprimer les series d'un host] (#supprimer-les-series-d'un-host)
* [obtenir les tags associés à une mesure] (#obtenir-les-tags-associés-à-une-mesure)
* [connaitre le contenu d'un tag] (#connaitre-le-contenu-d'un-tag)
* [afficher les 5 derniers résultats pour l'instance eth0 et la métriques interface_rx] (#afficher-les-5-derniers-résultats-pour-l'instance-eth0-et-la-métriques-interface_rx)


### un peu de théorie

#### les ports 
* port 8083, interface d'admin
* port 8086, utilisez pour attaquer la web API 
* port 8088, utilisez pour la mise en cluster

### la structure

#### SHOW MEASUREMENTS
On doit pouvoir faire un parrallèle entre un MEASUREMENTS et une table SQL

```
tcpconns_value
uptime_value
users_value
varnish_value
vmem_in
vmem_majflt
vmem_minflt
vmem_out
vmem_value
```

#### l'équivalent de describe
où tous les champs sont des tags (sauf le "time" qui n'apparaît pas )
```
SHOW TAG KEYS
```
Résultat
```
name: vmem_value
----------------
tagKey
host
type
type_instance
```
#### parser 

> select *  from vmem_value  where host='prdweb05' limit  5
name: vmem_value
----------------
time                    host            type            type_instance           value
1499472000959091000     prdweb05     vmpage_number   free_pages              699259
1499472000959098000     prdweb05     vmpage_number   zone_inactive_anon      214892
1499472000959104000     prdweb05     vmpage_number   zone_active_anon        1.733871e+06
1499472000959111000     prdweb05     vmpage_number   zone_inactive_file      1.343551e+06
1499472000959116000     prdweb05     vmpage_number   zone_active_file        956713

#### show series 
```
show series from vmem_value limit 5
key
vmem_value,host=ctsfmtbdd01,type=vmpage_action,type_instance=dirtied
vmem_value,host=ctsfmtbdd01,type=vmpage_action,type_instance=written
vmem_value,host=ctsfmtbdd01,type=vmpage_number,type_instance=active_anon
```

### obtenir le nom des métriques

```
influx -database collectd --execute 'SHOW MEASUREMENTS
```

### obtenir le nom des séries stockés

`show series` 


### exemple de requêtes

`influx -database collectd --execute "select * from /.*/ where host = 'pmdptvprdweb01' limit 1"`

### exemple de requêtes en select

```
select * from apache_value  where time > now() - 1h limit 1000;
```

### supprimer les series d'un host
En utilisant un tag Collectd 
  
```
DROP SERIES WHERE host = 'dnslvs2'
```

### obtenir les tags associés à une mesure

Pour la mesure **interface_rx** par exemple : 

```
SHOW TAG KEYS FROM "interface_rx"
```

### connaitre le contenu d'un tag

```
SHOW TAG VALUES FROM "interface_rx" WITH KEY = "instance"
```

### afficher les 5 derniers résultats pour l'instance eth0 et la métriques interface_rx 

```
select * from interface_rx where instance =~ /eth0/ limit 5
```

### afficher les métriques avec une clé par host

```
show tag values with key = host limit 5
```

### quelques commandes
#### les mesues
Voir toutes les mesures
```
show MEASUREMENTS
```
Voir certaines mesures
```
show MEASUREMENTS WITH MEASUREMENT =~ /swap/
```
Supprimer toutes les mesures

https://stackoverflow.com/questions/38587898/in-influxdb-how-to-delete-all-measurements
```
use collectd
DROP SERIES FROM /.*/
```
Voir les séries
```
show SERIES
```
#### les CQ
Voir les CQ
```
show CONTINUOUS QUERIES
```
Supprimer les CQ
```
drop CONTINUOUS QUERY cq_basic_br4 ON collectd
```
#### les rétentions
Voir les politiques de rententions
```
show RETENTION  POLICIES
```
ou
```
show RETENTION  POLICIES on collectd_a_6month
```
Créer une politique de retention
```
CREATE RETENTION POLICY rp52w ON collectd DURATION 52w REPLICATION 1 DEFAULT
```
Modifier une politique de retention
```bash
ALTER RETENTION POLICY default ON collectd_a_6month DURATION 26w REPLICATION 1 DEFAULT
```

### limiter et trier les résultat

```bash
select * from tail_value ORDER BY time ASC limit 5
```
