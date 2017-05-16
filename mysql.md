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
