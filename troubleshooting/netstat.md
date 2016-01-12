# netstat

La commande netstat permet, entre autre,  de connaitre l'état des sockets

## Utilisation typique
* voir les services réseaux offerts
* identifier des processus anormaux - analyse post-piratage
* estimer la charge réseau - nb de connexion en ESTABLISH

## lab de démonstration 
On monte le serveur de test
```
fg25:~# netcat -l -p 1025 &
```
On surveille le socket 10 fois par seconde
```
while true ; do sleep 0.1 ; netstat -antp | grep 1025 >>  /tmp/pouet ; done &
```
On envoi une string "pouet" sur le serveur
```
fg25:~# echo "pouet" | netcat -w 1 localhost 1025
```
Lecture du fichier
```
fg25:~# cat  /tmp/pouet
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
### analyse
On peut suivre la modification du socket, passant de LISTEN à ESTABLISHED puis, une fois la connexion close, puis en TIME_WAIT. 
