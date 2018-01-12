# Cassandra

## Installation

```bash
cat >/etc/apt/sources.list.d/cassandra.list<<EOF
deb http://www.apache.org/dist/cassandra/debian 30x main
deb http://www.apache.org/dist/cassandra/debian 39x main
EOF

apt update && apt install -y cassandra cassandra-tools
```

### Résolution "dns"

Pensez à déclarer les noeuds dans /etc/hosts

## Configuration

### Changer le nom du cluster

```bash
cluster_name: 'Kairos cluster'
```

### déclarer les seed provider

Déclarer dans seeds les différents noeuds  

```bash
seed_provider:
    # Addresses of hosts that are deemed contact points. 
    # Cassandra nodes use this list of hosts to find each other and learn
    # the topology of the ring.  You must change this if you are running
    # multiple nodes!
    - class_name: org.apache.cassandra.locator.SimpleSeedProvider
      parameters:
          # seeds is actually a comma-delimited list of addresses.
          # Ex: "<ip1>,<ip2>,<ip3>"
          - seeds: "10.0.145.202,10.0.145.201,10.0.145.203"
```

#### définir l'adresse d'écoute

```bash
listen_address: 10.0.145.202
```

### Activer les rpc 

```bash
start_rpc: true
rpc_address: 10.0.145.202
rpc_port: 9160
```

### Obtenir la liste des keyspaces

```bash
SELECT * FROM system_schema.keyspaces; 
```

Si vous avez installé **kairosdb**, le keyspace kairosdb doit apparaître.

### Vérifier la mise en cluster

```bash
nodetool status
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address       Load       Tokens       Owns (effective)  Host ID                               Rack
UN  10.0.145.201  314.14 KiB  256          34.2%             41e091d4-5df3-421c-b7b2-c85919588109  rack1
UN  10.0.145.202  196.86 KiB  256          32.6%             0674c1dd-4dfe-4539-a7c4-88fea05cfe1e  rack1
UN  10.0.145.203  326.17 KiB  256          33.3%             2528cbd6-e5c9-401c-8832-aa1d10b1fcbe  rack1
```
