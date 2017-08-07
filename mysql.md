* [purge des logs binaires] (#purge-des-logs-binaires)
* [se connecter avec un fichier] (#se-connecter-avec-un-fichier)

###  purge des logs binaires

```
PURGE BINARY LOGS BEFORE '2016-10-11 17:25:00';
```
### se connecter avec un fichier

```
 mysql --defaults-file=/etc/mysql/debian.cnf 
```

### error Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock
```
innodb_force_recovery = 1
```

# Galera

## installation

https://www.percona.com/doc/percona-xtradb-cluster/5.7/verify.html

## troubleshooting

Ressources

* https://www.percona.com/blog/2014/09/01/galera-replication-how-to-recover-a-pxc-cluster/

#### les bases de données ne sont plus accessibles
exemple : use tagada ;

Le noeud est en splitbrain et ne se considère pas comme possédant la version la plus à jour des datas.

### contrôle d'état

#### vérifier l'état du noeud courant

https://www.percona.com/doc/percona-xtradb-cluster/5.5/faq.html

```
MariaDB [(none)]> SELECT 1 FROM dual;
+---+
| 1 |
+---+
| 1 |
+---+
1 row in set (0.00 sec)
```
### synchro

#### quels ports sont utilisés pour la synchro

* communication du groupe : 4567 
* state transfert : 4444
* Incremental state transfert : 4568

####  faire une synchro tout en laissant un noeud non chargé

Sur un cluster de trois machine, le noeud 3 est tombé et que le noeud 1 est en production, il faudrat inviter le noeud  3 à ce synchroniser sur le 2 et non sur le 1
```
wsrep_sst_donor             = "noeud 2"
```
#### vérifier que la synchro se fait bien au niveau système

``` bash
ps auxf | grep mysql                                                                                                                                                                                         
mysql    16250  0.7  0.9 708040 234092 pts/1   Sl   21:43   0:03                      \_ mysqld
mysql    16260  0.0  0.0   4336   760 pts/1    S    21:43   0:00                      |   \_ sh -c wsrep_sst_rsync --role 'joiner' --address '10.0.132.53' --datadir '/var/lib/mysql/' --defaults-file '/etc/mysql/my.cnf' --defaults-group-suffix '' --parent '16250' --binlog '/var/log/mysql/mysql-bin' 
mysql    16261  0.1  0.0  13420  3160 pts/1    S    21:43   0:00                      |       \_ /bin/bash -ue /usr//bin/wsrep_sst_rsync --role joiner --address 10.0.132.53 --datadir /var/lib/mysql/ --defaults-file /etc/mysql/my.cnf --defaults-group-suffix  --parent 16250 --binlog /var/log/mysql/mysql-bin
mysql    16293  0.0  0.0  12584  2484 pts/1    S    21:43   0:00                      |           \_ rsync --daemon --no-detach --port 4444 --config /var/lib/mysql//rsync_sst.conf
mysql    16390  0.0  0.0  22056  2644 pts/1    S    21:43   0:00                      |           |   \_ rsync --daemon --no-detach --port 4444 --config /var/lib/mysql//rsync_sst.conf
mysql    16396 44.4  0.0  22316  1420 pts/1    S    21:43   3:24                      |           |       \_ rsync --daemon --no-detach --port 4444 --config /var/lib/mysql//rsync_sst.conf
```

#### vérifier que la synchro se fait bien au niveau réseau

```
 netstat  -antpc | grep 4444
tcp        0      0 0.0.0.0:4444            0.0.0.0:*               LISTEN      16293/rsync
tcp    48316      0 10.0.132.53:4444        10.0.132.52:26898       ESTABLISHED 16390/rsync
tcp6       0      0 :::4444                 :::*                    LISTEN      16293/rsync
tcp        0      0 0.0.0.0:4444            0.0.0.0:*               LISTEN      16293/rsync
tcp        0      0 10.0.132.53:4444        10.0.132.52:26898       ESTABLISHED 16390/rsync
tcp6       0      0 :::4444                 :::*                    LISTEN      16293/rsync
tcp        0      0 0.0.0.0:4444            0.0.0.0:*               LISTEN      16293/rsync
tcp     9356      0 10.0.132.53:4444        10.0.132.52:26898       ESTABLISHED 16390/rsync
tcp6       0      0 :::4444                 :::*                    LISTEN      16293/rsync
tcp        0      0 0.0.0.0:4444            0.0.0.0:*               LISTEN      16293/rsync
tcp        0      0 10.0.132.53:4444        10.0.132.52:26898       ESTABLISHED 16390/rsync
tcp6       0      0 :::4444                 :::*                    L
```

#### Optimisation MySQL

En cas de jointure (JOIN), MySQL va créer un fichier temporaire dans /tmp.
On peut alors monter un tmpfs dans /tmp ou faire passer en ram les fichiers temporaire de jointure

###  connaitre le nombre d'enregistrements

 SELECT COUNT(*) FROM "ma table" ;


Changement du query_cache_size ne change rien

SET GLOBAL query_cache_size = 134217728 ;


UPDATE paragraphs_item SET revision_id='263375', bundle='field_ameli_paragraph_simple', field_name='field_ameli_paragraphs_blocks', archived='1'


thread_cache_size = 16384

#### profile


