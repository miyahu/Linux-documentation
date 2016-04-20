Littérature
-----------

<http://soat.developpez.com/articles/elasticsearch/>

<http://fr.slideshare.net/dadoonet/elasticsearch-devoxx-france-2012>

Réglage pour un standalone :
* http://blog.lavoie.sl/2012/09/configure-elasticsearch-on-a-single-host.html

Concepts
--------

### terminologie et architecture

ElasticSearch est un moteur de recherche composé de :

-   un moteur d'indexation de documents
-   un moteur de recherche sur les index

<!-- -->

-   noeud : une instance d’ElasticSearch
-   cluster : un ensemble de noeuds
-   index : un index est une collection de documents qui ont des
    caractéristiques similaires.
-   shards : partitions ou sont stockés les documents constituant un
    index, un index peut s'appuyer sur plus d'un shard.
-   replica : copie additionnel d'un index dans un cluster ElasticSearch

<!-- -->

-   partition primaire (primary shard) : qui correspond à la partition
    élue principale dans l'ensemble du cluster. C'est là que se fait
    l'indexation par Lucene. Il n'y en a qu'une seule par shard dans
    l'ensemble du cluster ;
-   partition secondaire (secondary shard) : qui sont les partitions
    secondaires stockant les réplicas des partitions primaires.

Par défaut, chaque index est répartie sur 5 shards primaires et 1
réplica.

Rivières (Rivers) : permettent de "verser" des données dans ES.

-   le replicat et le Shard original ne peuvent pas être sur le même
    node

### cas concret

    curl -XGET http://localhost:9200/_cat/shards 
    graylog2_8                 0 p STARTED 5013226   2.4gb 127.0.0.1 Aquarian 
    graylog2_8                 3 p STARTED 5005312   2.4gb 127.0.0.1 Aquarian 
    graylog2_8                 1 p STARTED 5001062   2.4gb 127.0.0.1 Aquarian 
    graylog2_8                 2 p STARTED 4981813   2.4gb 127.0.0.1 Aquarian 
    apache_logstash-2015.08.04 2 p STARTED    6955   2.2mb 127.0.0.1 Aquarian

Explication :

-   première colonne : nom de l'index
-   seconde : numéro du shard
-   troisième : type (primaire ou replica)
-   quatrième : statue
-   cinquième : id ??
-   sixième : taille
-   septième : adresse du nœud
-   huitième : nom du nœud

### rôles et scalabilitée

Dans le cas d'un gros cluster, il est intéressant de séparer les rôles 

* Master-eligible node : qui peut devenir master et permet la création/suppression d'index et assure les fonctions de gestion du cluster 
* Data node : qui possède des données et effectue des opération CRUD dessus
* Client node : qui transmet les requêtes (et peut être les fusionnes ?)


Doc :
https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html

#### Un dessin qui vaut mille mots 

https://www.elastic.co/assets/blt9ae0b9498554824c/cluster-topology.svg


Installation et configuration
=============================

Installation
------------

`echo "deb `[`http://packages.elastic.co/elasticsearch/1.6/debian`](http://packages.elastic.co/elasticsearch/1.6/debian)` stable main" > /etc/apt/sources.list.d/elastic.list`

`apt install elasticsearch`\
`systemctl enable elasticsearch`\
`systemctl start elasticsearch`

Par défaut, un *node name* est généré dynamiquement par Elasticsearch

Mise en cluster
---------------

-   définir un *cluster.name* sur chacun des noeuds ex

`cluster.name: kaiju`

-   définir un *node.name* sur chacun des noeuds ex

`node.name: "Godzilla" `

Attention, si vous mettez *node.master* à *true* sur le master et que le
slave tourne en standalone, ce dernier refusera les connexions si le
master est down.

### Haproxy

    frontend es_front 0.0.0.0:9200
            use_backend es_back

    backend es_back
            mode tcp
            balance leastconn
            option httpchk
            server es1 localhost:9201 check inter 5s weight 1 
            server es2 bricozor6:9201 check inter 5s weight 1 backup

### scénarios testés

  -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  node 1                                              node 2                                              résultat
  --------------------------------------------------- --------------------------------------------------- ---------------------------------------------------------------------
  node offline                                        node online + /test/test/3 -d '{"key2":"value 2"}   ok après synchronisation\
                                                                                                          Pas d'actions manuelles requises

  node online + /test/test/4 -d '{"key2":"value 2"}   node offline                                        ok après synchronisation\
                                                                                                          Pas d'actions manuelles requises

  node online + /test/test/5 -d '{"key2":"value 2"}   node online + /test/test/5 -d '{"key2":"value 2"}   ok après synchronisation, il prend la modification la plus récente\
                                                                                                          Pas d'actions manuelles requises
  -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  : Conditions testées

Installation de plugins
-----------------------

### head

`cd /usr/share/elasticsearch/bin && \`\
`./plugin --install mobz/elasticsearch-head`

Accès <http://localhost:9200/_plugin/head/>

### HQ

`cd /usr/share/elasticsearch/bin && \`\
`./plugin -install royrusso/elasticsearch-HQ`

Accès <http://localhost:9200/_plugin/HQ/>

### Bigdesk

`cd /usr/share/elasticsearch/bin && \`\
`./plugin -install lukas-vlcek/bigdesk`

Accès <http://localhost:9200/_plugin/bigdesk/>

Exploitation
============

Pilotage
--------

###  Obtenir des stats approfondies
`curl localhost:9200/_stats | python -m json.tool | less`

### Arrêt du cluster

`curl -XPOST '`[`http://localhost:9200/_shutdown`](http://localhost:9200/_shutdown)`'`

### Status du cluster

` curl -XGET `[`http://localhost:9200/_cluster/health?pretty`](http://localhost:9200/_cluster/health?pretty)

### Status des nodes

```
 curl localhost:9200/_cat/nodes
prdlamp2 10.0.95.12 71 56 0.92 d m prdlamp2 
prdlamp1 10.0.95.11 49 57 1.25 d * prdlamp1 
test1    10.0.95.90  2 60 0.02 - - test1
```
Explication :
première colonne : nom du noeud
seconde : adresse IP
troisième : ??
quatrième : ??
cinquième : ??
sixième : ??
septième : "m" pour master elligible, "*" pour master effectif et - ??

### Status des shards (et replicas)
```
curl -XGET http://localhost:9200/_cat/shards
```
Troubleshooting
---------------

### Elastichsearch est en rouge

Si le serveur Elastic tourne en standalone, je pense que les replicas
shards ne servent à rien (pas d'autres noeuds), il est donc possible de
les désactiver :

    curl -XPUT 'localhost:9200/mon_index_de_la_mort/_settings' -d '
    {

        "index" : {
            "number_of_replicas" : 0
        }
    }'

Sinon

1\) vérifier si des shards sont orphelins ("unassigned\_shards" : 2,)

    curl -XGET http://localhost:9200/_cluster/health?pretty          
    {
      "cluster_name" : "nom du cluster",
      "status" : "red",
      "timed_out" : false,
      "number_of_nodes" : 1,
      "number_of_data_nodes" : 1,
      "active_primary_shards" : 77,
      "active_shards" : 77,
      "relocating_shards" : 0,
      "initializing_shards" : 0,
      "unassigned_shards" : 2,
      "number_of_pending_tasks" : 0,
      "number_of_in_flight_fetch" : 0
    }

2\) si unassigned\_shards est différent de 0, récupérer la liste des
shards "UNASSIGNED" et le nom du node avec un

    curl -XGET http://localhost:9200/_cat/shards 
    graylog2_8                 0 p STARTED 5013226   2.4gb 127.0.0.1 Aquarian 
    graylog2_8                 3 p STARTED 5005312   2.4gb 127.0.0.1 Aquarian 
    graylog2_8                 1 p STARTED 5001062   2.4gb 127.0.0.1 Aquarian 
    graylog2_8                 2 p STARTED 4981813   2.4gb 127.0.0.1 Aquarian 
    apache_logstash-2015.08.04 2 p STARTED    6955   2.2mb 127.0.0.1 Aquarian

Explication :

-   première colonne : nom de l'index
-   seconde : numéro du shard
-   troisième : type (primaire ou replica)
-   quatrième : statue
-   cinquième : id ??
-   sixième : taille
-   septième : adresse du nœud
-   huitième : nom du nœud

2.1) récupérer le numéro du shard non assigné (seconde colonne)

2.2) récupérer le nom de l'index non assigné (première colonne)

2.3) récupérer le nom du node (dernière colonne)

3) enfin, avec tous les éléments récupérés, réassocier le shard orphelin
au noeud(-noeud) :

    curl -XPOST 'localhost:9200/_cluster/reroute' -d '{
            "commands" : [ {
                  "allocate" : {
                      "index" : "nom de l'index", 
                      "shard" : numéro du shard, 
                      "node" : "nom du node", 
                      "allow_primary" : true
                  }
                }
            ]
        }'; 

Si le serveur Elastic tourne en standalone, je pense que les replicas
shards ne servent à rien (pas d'autres noeuds), il est donc possible de
les désactiver :
```
index.number_of_replicas: 0
```