# netstat

Niveau Facile

Attention, avec netstat, le diable est dans les détails, il y a peu d'information, donc il faut réfléchir ... 

## Présentation
La commande netstat permet d'obtenir des informations sur les connexions et des statistiques. 

## Utilisation typique
* voir les services réseaux offerts
* identifier des processus anormaux - analyse post-piratage
* estimer la charge réseau - nb de connexion en ESTABLISHED
* voir si les tampons d'émission ou reception (Send-Q et Recv-Q) sont utilisés de manière importantes
 
## Exemple d'utilisation
```
fg25~# netstat -4lntp
```
## lab de démonstration 
On monte le serveur de test
```
fg25:~# netcat -l -p 1025 &
```
Puis on surveille le socket 10 fois par seconde (valeur arbitraire mais suffisement fréquente pour capturer un évenement)
```
while true ; do sleep 0.1 ; netstat -4antp | grep 1025 >>  /tmp/pouet ; done &
```
Enfin, envoi la string "pouet" sur le serveur
```
fg25:~# echo "pouet" | netcat -w 1 localhost 1025
```
### Post analyse
Lecture du fichier (sortie tronquée et concatenée)
```
fg25:~# cat  /tmp/pouet
Proto Recv-Q Send-Q Adresse locale          Adresse distante        Etat        PID/Program name
tcp        0      0 0.0.0.0:1025            0.0.0.0:*               LISTEN     3160/netcat         
tcp        0      0 0.0.0.0:1025            0.0.0.0:*               LISTEN     3160/netcat         
tcp        0      0 0.0.0.0:1025            0.0.0.0:*               LISTEN     3160/netcat         
tcp        0      0 127.0.0.1:57237         127.0.0.1:1025          ESTABLISHED-                   
tcp        0      0 127.0.0.1:1025          127.0.0.1:57237         ESTABLISHED3160/netcat         
tcp        0      0 127.0.0.1:57237         127.0.0.1:1025          ESTABLISHED3217/netcat         
tcp        0      0 127.0.0.1:1025          127.0.0.1:57237         ESTABLISHED3160/netcat
tcp        0      0 127.0.0.1:57237         127.0.0.1:1025          TIME_WAIT  -                   
tcp        0      0 127.0.0.1:57237         127.0.0.1:1025          TIME_WAIT  -                   
tcp        0      0 127.0.0.1:57237         127.0.0.1:1025          TIME_WAIT  -
```

* On peut suivre la modification du socket, passant de **LISTEN** à **ESTABLISHED** puis, une fois la connexion close, puis en **TIME_WAIT** avant de passer en FIN_WAIT (non visible). 
* on pourra également suivre le changement de PID du processus - client en **3217** et serveur en **3160**
* ainsi que les colonnes des données transmises et reçues sont à **0** car la string "pouet" est trop petite (6 octets) pour être capturée.  
