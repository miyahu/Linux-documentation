* [create collection on solrcloud] (#create-collection-on-solrcloud)


### create collection on solrcloud

Si je veux créer un core

curl "http://admin:tagada@212.47.228.48:8080/solr/admin/collections?action=CREATE&name=tagada&numShards=1&replicationFactor=1&collection.configName=tagada"


### delete collections

https://community.hortonworks.com/articles/7082/how-to-cleanup-solrcloud-entries-in-zookeeper.html

ensuite 

https://community.hortonworks.com/articles/7081/best-practice-chroot-your-solr-cloud-in-zookeeper.html



