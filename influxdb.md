### obtenir le nom des métriques

``influx -database collectd --execute 'SHOW MEASUREMENTS̀`

### obtenir le nom des séries stockés

`use mydb`

`select * from /.*/ limit 1

ou plutôt 

 `show series` 

https://docs.influxdata.com/influxdb/v0.9/query_language/schema_exploration/

encore mieux 

`influx -database collectd --execute 'show series'`



