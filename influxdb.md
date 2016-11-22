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

* port 8083, interface d'admin
* port 8086, utilisez pour attaquer la web API 
* port 8088, utilisez pour la mise en cluster

### obtenir le nom des métriques

```
influx -database collectd --execute 'SHOW MEASUREMENTS
```

### obtenir le nom des séries stockés

```use mydb```

`select * from /.*/ limit 1

ou plutôt 

 `show series` 

https://docs.influxdata.com/influxdb/v0.9/query_language/schema_exploration/

encore mieux 

`influx -database collectd --execute 'show series'`

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
