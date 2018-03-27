# Redis

doc https://www.wanadev.fr/30-tuto-redis-le-cluster-redis-3-0/

## Installation et configuration d'un cluster

Ajouter 

```bash
protected-mode no
```
A la conf pour autoriser le bind sur *

### ajout d'une seconde instance

changement du port

```bash
cp -v /etc/redis/redis700{0,1}.conf &&  sed -i 's/7000/7001/' /etc/redis/redis7001.conf
```
changement du nodes.conf

```bash
sed -i 's/nodes.conf/nodes2.conf/' /etc/redis/redis7001.conf
```
la démarrer

```bash
redis-server /etc/redis/redis7001.conf &
```

### installation  de trib 

#### copie dans le PATH

```bash
cp /usr/share/doc/redis-tools/examples/redis-trib.rb /usr/bin/ 
```

#### installation des dépendances

```bash
apt install ruby -y
gem install rubygems-update
update_rubygems
gem install redis -v 3.3.5
```


### ajout des noeuds au cluster

si message  ̀ERR Slot 0 is already busy (Redis::CommandError)̀`

Alors sur un des noeud lancer 

```bash
FLUSHALL
CLUSTER RESET 
```
puis, si pas de problème de slot

```bash
redis-trib.rb create --replicas 1 10.240.0.5:7000 10.240.0.6:7000 10.240.0.7:7000 10.240.0.5:7001 10.240.0.6:7001 10.240.0.7:7001
```
#### vérification

```bash
redis-cli -p 7000 -h localhost  cluster nodes
2b795ce5635247d51dd5bfe644fa2d79a50dbd10 10.240.0.7:7000 master - 0 1522080289879 3 connected 10923-16383
01f47e4a30c92ecf79842f2f032c65ac5997091c 10.240.0.6:7000 master - 0 1522080288877 2 connected 5461-10922
166147d04ed1b97e3ccb199c2476ba6179cc7703 10.240.0.6:7001 slave 3006caeb0619668dde6d9d15e516082c7a3dd221 0 1522080289378 5 connected
3006caeb0619668dde6d9d15e516082c7a3dd221 10.240.0.5:7000 myself,master - 0 0 1 connected 0-5460
fa54a13138953a66931011cdc05587536ad83ab4 10.240.0.5:7001 slave 01f47e4a30c92ecf79842f2f032c65ac5997091c 0 1522080287874 4 connected
0adbf617f58628df8d442a8215580656dda1fd1d 10.240.0.7:7001 slave 2b795ce5635247d51dd5bfe644fa2d79a50dbd10 0 1522080288376 6 connected
```



#### A faire ####

https://www.wanadev.fr/30-tuto-redis-le-cluster-redis-3-0/

Lors de la réinsertion de l'ancien noeud, celui-çi redevient entièrement slave, pour lui faire reprendre 
du service en master, tapez "CLUSTER FAILOVER FORCE"  

Pour comprendre comment son réparties les shards et les rôles, utilisez redis-cli -p 7000 -h localhost  cluster nodes

* vous verrez que par défaut, les slaves (réplicas) sont sur les instances 7001, sauf en cas de bascule !!!
* vous devrez vérifier, pour les master, la répartition des shardes qui est visible dans la derbière colonne ex 10923-16383
* dans l'exemple ci-dessous 
```bash
86daa6dfb47010e7e3b0e3defd8f61bbcba13c50 10.0.2.42:7000 master - 0 1428995099566 2 connected 5461-10922
e915e680c678037575410dfd3f4377da0bbca8c3 10.0.2.42:7001 slave 3d7821f6693dd7af20903de328126040ef271faa 0 1428995100067 5 connected
f6cc14a662348c208b757571b9725a364ea2e521 10.0.2.43:7001 slave ebed1b997c21921350b1065aefa3e39fabb3876e 0 1428995099766 6 connected
ebed1b997c21921350b1065aefa3e39fabb3876e 10.0.2.43:7000 master - 0 1428995099766 3 connected 10923-16383
2e44642dfc57854fb0e294de2df015428936b4fc 10.0.2.41:7001 slave 86daa6dfb47010e7e3b0e3defd8f61bbcba13c50 0 1428995100067 4 connected
3d7821f6693dd7af20903de328126040ef271faa 10.0.2.41:7000 myself,master - 0 0 1 connected 0-5460
```

on peut voir que l'id 3d7821f6693dd7af20903de328126040ef271faa est en master sur 10.0.2.41:7000(première colonne et dernière ligne) et qu'il est répliqué sur 10.0.2.42:7001 (quatrième colonne et deuxième ligne) 
de la sortie ci-dessus nous pouvons déduire que le cluster est  composé de 3 shards répliqués avec un facteur de 1, sur 3 noeuds et 6 instances.

Pour information, un slot (ou groupe de) ne peut être accessible qu'à un endroit à la fois (un node donc)

### voir la répartition des slots dans le cluster

```bash
root@instance-1:~# redis-cli -p 7000 cluster slots
1) 1) (integer) 5461
   2) (integer) 10922
   3) 1) "10.240.0.6"
      2) (integer) 7000
      3) "01f47e4a30c92ecf79842f2f032c65ac5997091c"
   4) 1) "10.240.0.5"
      2) (integer) 7001
      3) "fa54a13138953a66931011cdc05587536ad83ab4"
2) 1) (integer) 10923
   2) (integer) 16383
   3) 1) "10.240.0.7"
      2) (integer) 7000
      3) "2b795ce5635247d51dd5bfe644fa2d79a50dbd10"
   4) 1) "10.240.0.7"
      2) (integer) 7001
      3) "0adbf617f58628df8d442a8215580656dda1fd1d"
3) 1) (integer) 0
   2) (integer) 5460
   3) 1) "10.240.0.5"
      2) (integer) 7000
      3) "3006caeb0619668dde6d9d15e516082c7a3dd221"
   4) 1) "10.240.0.6"
      2) (integer) 7001
      3) "166147d04ed1b97e3ccb199c2476ba6179cc7703 
```
