# strace

strace permet de suivre les appels systèmes et les signaux lié au processus. 

Exemple concret 

Je lance un process bidon
```
francegalop25:~# netcat -l -p 1025 &
```

J'en vérifie son execution
```
francegalop25:~# netstat -lntp | grep 1025
tcp        0      0 0.0.0.0:1025            0.0.0.0:*               LISTEN     21083/netcat
```

et j'envoi des données bidon
```
francegalop25:~# echo "pouet" | netcat -w 1 localhost 1025
pouet
```

