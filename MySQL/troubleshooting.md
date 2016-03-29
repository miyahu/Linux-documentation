### lister les requêtes en cours
```
mysqladmin processlist
```


### obtenir la liste des variables 
```
 mysqladmin variables
```
### obtenir des statistiques - ex cache 
```
 mysqladmin  extended-status
 ```

### ERROR 2013 (HY000): Lost connection to MySQL server during query 

Rien n'apparaît dans les logs, mystère

lancer le démon manuellement et en *foreground* avec
```
mysqld -vvv
```
Sortie
```
160203 14:13:43  InnoDB: Database was not shut down normally!
InnoDB: Starting crash recovery.
InnoDB: Reading tablespace information from the .ibd files...
InnoDB: Restoring possible half-written data pages from the doublewrite
InnoDB: buffer...
160203 14:13:43  InnoDB: Starting log scan based on checkpoint at
InnoDB: log sequence number 225 2612227084.
InnoDB: Doing recovery: scanned up to log sequence number 225 2612227084
InnoDB: Last MySQL binlog file position 0 287185, file name /var/log/mysql/mysql-bin.007681
160203 14:13:43  InnoDB: Started; log sequence number 225 2612227084
InnoDB: !!! innodb_force_recovery is set to 4 !!!
160203 14:13:43 [Note] Recovering after a crash using /var/log/mysql/mysql-bin
160203 14:13:43 [Note] Starting crash recovery...
160203 14:13:43 [Note] Crash recovery finished.
160203 14:13:43 [Note] mysqld: ready for connections.
```
Puis lancer la commande faisant planter MySQL
```
fg21:~# mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 1
Server version: 5.0.32-Debian_7etch12-log Debian etch distribution

Type 'help;' or '\h' for help. Type '\c' to clear the buffer.

mysql> drop database fg ;
ERROR 2013 (HY000): Lost connection to MySQL server during query
mysql> Bye
```
Et enfin regardons la *backtrace*
```
160203 14:14:07InnoDB: Assertion failure in thread 3036470192 in file fsp0fsp.c line 3116
InnoDB: Failing assertion: xdes_get_state(descr, mtr) == XDES_FSEG
InnoDB: We intentionally generate a memory trap.
InnoDB: Submit a detailed bug report to http://bugs.mysql.com.
InnoDB: If you get repeated assertion failures or crashes, even
InnoDB: immediately after the mysqld startup, there may be
InnoDB: corruption in the InnoDB tablespace. Please refer to
InnoDB: http://dev.mysql.com/doc/refman/5.0/en/forcing-recovery.html
InnoDB: about forcing recovery.
mysqld got signal 11;
```
En recherchant la phrase "InnoDB: Assertion failure in thread  in file fsp0fsp.c line 3116" sur Internet, je tombe sur un bug référencé 

https://bugs.mysql.com/bug.php?id=74187```

**this crash is due to improperly creating innodb tablespace/subsystem from the start.  you need to recreate it from scratch (innodb log files and ibdata).**


