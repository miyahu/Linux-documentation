* [un peu de théorie] (#un peu de théorie)
* [obtenir le nom des métriques](#obtenir-le-nom-des-métriques)
* [obtenir le nom des séries stocké](#obtenir-le-nom-des-séries-stockés)
* [exemple de requêtes](#exemple-de-requêtes)
* [exemple de requêtes en select](#exemple-de-requêtes-en-select)
* [supprimer les series d'un host] (#supprimer-les-series-d'un-host)


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
cas d'un tag Collectd 
  
```
DROP SERIES WHERE host = 'dnslvs2'
```
