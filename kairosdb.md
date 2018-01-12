# kairosdb 

## Configuration Kairosdb pour cassandra en backend

### Le fichier de configuration

```bash
 grep -vE "^#|^$"  /opt/kairosdb/conf/kairosdb.properties | grep cassandra
kairosdb.service.datastore=org.kairosdb.datastore.cassandra.CassandraModule
kairosdb.datastore.cassandra.cql_host_list=10.0.145.201:9160,10.0.145.202:9160,10.0.145.203:9160
kairosdb.datastore.cassandra.keyspace=kairosdb
kairosdb.datastore.cassandra.simultaneous_cql_queries=20
kairosdb.datastore.cassandra.query_reader_threads=6
kairosdb.datastore.cassandra.row_key_cache_size=50000
kairosdb.datastore.cassandra.string_cache_size=50000
kairosdb.datastore.cassandra.read_consistency_level=ONE
kairosdb.datastore.cassandra.write_consistency_level=QUORUM
kairosdb.datastore.cassandra.connections_per_host.local.core=5
kairosdb.datastore.cassandra.connections_per_host.local.max=100
kairosdb.datastore.cassandra.connections_per_host.remote.core=1
kairosdb.datastore.cassandra.connections_per_host.remote.max=10
kairosdb.datastore.cassandra.max_requests_per_connection.local=128
kairosdb.datastore.cassandra.max_requests_per_connection.remote=128
kairosdb.datastore.cassandra.max_queue_size=500
kairosdb.datastore.cassandra.use_ssl=false
```

### vérifier sur cassandra, que le keyspace kairosdb est créé

```bash
root@cassandra2:~ # cqlsh  10.0.145.202 9042                                                                                                   
Connected to Kairos cluster at 10.0.145.202:9042.
[cqlsh 5.0.1 | Cassandra 3.9 | CQL spec 3.4.2 | Native protocol v4]
Use HELP for help.
cqlsh> SELECT * FROM system_schema.keyspaces;

 keyspace_name      | durable_writes | replication
--------------------+----------------+-------------------------------------------------------------------------------------
           kairosdb |           True | {'class': 'org.apache.cassandra.locator.SimpleStrategy', 'replication_factor': '1'}
        system_auth |           True | {'class': 'org.apache.cassandra.locator.SimpleStrategy', 'replication_factor': '1'}
      system_schema |           True |                             {'class': 'org.apache.cassandra.locator.LocalStrategy'}
 system_distributed |           True | {'class': 'org.apache.cassandra.locator.SimpleStrategy', 'replication_factor': '3'}
             system |           True |                             {'class': 'org.apache.cassandra.locator.LocalStrategy'}
      system_traces |           True | {'class': 'org.apache.cassandra.locator.SimpleStrategy', 'replication_factor': '2'}

(6 rows)
cqlsh>
```
