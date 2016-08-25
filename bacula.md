* [bacula-director ne démarre pas](#bacula-director-ne-démarre-pas)
* [méthodes de troubleshooting bacula](#méthodes-de-troubleshooting-bacula)

## bacula-director ne démarre pas
Plusieurs possibilitées

1. une conf cliente est présente dans /usr/local/conf/bacula/clients/ mais non présente dans la base de données Postgres 

## méthodes de troubleshooting bacula

sur le client

1. récupérer le PID du process avec un netstat -lntp | grep bacula
2. stracer avec un strace -v -f -t -s 5000 -o /tmp/out -p $PID
3. tcpdumper avec un tcpdump -vi any tcp and port 9102 or port 9103

