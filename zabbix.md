* [terminologie] (#terminologie)

### terminologie

* item : une sonde par exemple
* trigger : une action 
* macros : variable 

typiquement, on créé une sonde qui récupère des données, puis, dessus, on créé un trigger pour detecter un changement de valeur par exemple.   

### macros

Liste des variables (global ou propre à un élément)

### test zabbix agent

`zabbix_get -s monserveur  -k "mongodb.repli_status["root","tsoing"]"`


