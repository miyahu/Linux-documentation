* [create collection on solrcloud] (#create-collection-on-solrcloud)


### create collection on solrcloud

Si je veux créer un core

curl "http://admin:tagada@212.47.228.48:8080/solr/admin/collections?action=CREATE&name=tagada&numShards=1&replicationFactor=1&collection.configName=tagada"


### delete collections

https://community.hortonworks.com/articles/7082/how-to-cleanup-solrcloud-entries-in-zookeeper.html

ensuite 

https://community.hortonworks.com/articles/7081/best-practice-chroot-your-solr-cloud-in-zookeeper.html

https://www.eolya.fr/2013/06/14/administration-de-solrcloud-solr-4-0/




/opt/solr/example/scripts/cloud-scripts/zkcli.sh  -cmd upconfig -zkhost localhost:2181 -confdir /opt/solr/example/solr/collection1  -confname config1


création de la conf :
/opt/solr/example/scripts/cloud-scripts/zkcli.sh  -cmd upconfig -zkhost localhost:2181,10.0.133.72:2181 -confdir /opt/solr/example/solr/collection1/conf/  -confname config4

création du core
curl "http://localhost:8983/solr/admin/collections?action=CREATE&name=config4&numShards=1"



