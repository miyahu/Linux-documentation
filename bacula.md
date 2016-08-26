* [bacula-director ne démarre pas](#bacula-director-ne-démarre-pas)
* [méthodes de troubleshooting bacula](#méthodes-de-troubleshooting-bacula)
* [status des jobs](#status-des-jobs)

## bacula-director ne démarre pas
Plusieurs possibilitées

1. une conf cliente est présente dans /usr/local/conf/bacula/clients/ mais non présente dans la base de données Postgres 

## méthodes de troubleshooting bacula

sur le client

1. récupérer le PID du process avec un netstat -lntp | grep bacula
2. stracer avec un strace -v -f -t -s 5000 -o /tmp/out -p $PID
3. tcpdumper avec un tcpdump -vi any tcp and port 9102 or port 9103

## status des jobs

### Dans la bconsole

* Scheduled Jobs : en attente d'execution
* Running Jobs : en cours d'execution OU en anomalie de démarrage
* Terminated Jobs : terminé, mais les canceled sont mis dedans

### Vérifions sur le "storage"

```
netstat -laptn |grep 9103
tcp        0      0 0.0.0.0:9103            0.0.0.0:*               LISTEN      32147/bacula-sd 
tcp        0      0 10.10.1.103:9103        10.0.69.11:58196        ESTABLISHED 32147/bacula-sd 
tcp        0      0 10.10.1.103:9103        10.0.69.100:44128       ESTABLISHED 32147/bacula-sd
```

On peut voir que des serveurs de l'archis "69" sont en cours de backup.
