# strace

Niveau avancé

## Présentation
strace permet de suivre les appels systèmes et les signaux liés à un processus. 

Un appel système peut un code retour et/ou une erreur ex **bind** retourne **EADDRINUSE** si l'adresse et le port sont déjà utilisés. 

## Utilisation typique
* connaitre les actions précise d'un processus - 
* savoir quelles sont les ressources accéder par un processus - ouverture d'un socket
* connaitre les données traitées par un processus - écriture dans un log
* calculer le temps consommé par les appels systèmes et les comparer - savoir quelle appel occupe le processus php
* 
## Exemple concret 

Je met un processus netcat en écoute local sur le port 1025 (netcat serveur) , ensuite, avec un autre netcat (netcat client), j'ouvre une connexion vers ce port et transmet chaine "pouet" ; après 1 seconde, je ferme la connexion. 

Je lance le process bidon
```
fg25:~# strace -s -v -t -s 5000 -o /tmp/out netcat -l -p 1025 &
```

J'en vérifie son execution
```
fg25:~# netstat -lntp | grep 1025
tcp        0      0 0.0.0.0:1025            0.0.0.0:*               LISTEN     21083/netcat
```

et j'envoi des données bidon
```
fg25:~# echo "pouet" | netcat -w 1 localhost 1025
pouet
```

### Analyse

Maintenant on regarde la trace et on essaye de l'interpreter.
```
fg25:~# cat /tmp/out
     1  13:28:20 execve("/bin/netcat", ["netcat", "-l", "-p", "1025"], [/* 17 vars */]) = 0
```
Mise en écoute du netcat 
```
...
...
...
   202  13:28:20 read(3, "", 4096)              = 0
   203  13:28:20 close(3)                       = 0
   204  13:28:20 munmap(0xb7f38000, 4096)       = 0
   205  13:28:20 socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) = 3
```
création de la socket TCP (SOCK_STREAM) sur IPV4 (PF_INET,) pour le netcat serveur 
```
   206  13:28:20 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
   207  13:28:20 bind(3, {sa_family=AF_INET, sin_port=htons(1025), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
```
assignation de l'adresse "0.0.0.0" et du port "1025" au netcat serveur (fd 3)

```
   208  13:28:20 listen(3, 1)                   = 0
```
écoute du processus sur le socket 
```
   212  13:28:20 accept(3, {sa_family=AF_INET, sin_port=htons(54425), sin_addr=inet_addr("127.0.0.1")}, [16]) = 4
```
connexion sur le socket par le netcat client
```
   215  13:28:30 close(3)                       = 0
```
Le bind du netcat serveur se termine, il cesse d'écouter sur le port 1025 mais continue de servir la connexion ouverte  
```
   216  13:28:30 getsockname(4, {sa_family=AF_INET, sin_port=htons(1025), sin_addr=inet_addr("127.0.0.1")}, [16]) = 0
```
ben euh ...
```
   217  13:28:30 select(16, [0 4], NULL, NULL, NULL) = 1 (in [4])
```
le processus ? continu à scruter ses fd, de manière non bloquante
```
   218  13:28:30 read(4, "pouet\n", 8192)       = 6
```
Lecture de la chaine "pouet" (6 octets) sur le socket serveur (fd 4)
```
   219  13:28:30 write(1, "pouet\n", 6)         = 6
```
Ecriture de la chaine "pouet" (6 octets) sur la sortie standard du netcat serveur (fd 0)
```
   220  13:28:30 select(16, [0 4], NULL, NULL, NULL) = 1 (in [4])
   221  13:28:32 read(4, "", 8192)              = 0
```
fermeture du socket serveur présenté au client netcat (fd 4) 
```
   222  13:28:32 close(4)                       = 0
```
sortie avec code 0
```
   223  13:28:32 exit_group(0)                  = ?
```

Description des appels systèmes rencontrés :

* execve : execute program 
* socket : create an endpoint for communication
* bind : bind a name to a socket
* listen : listen for connections on a socket
* accept, accept4 : accept a connection on a socket
* getsockname : get socket name - getsockname() returns the current address to which the socket sockfd is bound, in the buffer pointed to by addr
* select,  pselect, FD_CLR, FD_ISSET, FD_SET, FD_ZERO : synchronous I/O multiplexing - select() and pselect() allow a program to monitor multiple file descriptors, waiting until one or more of the file descriptors become "ready" for some class of I/O operation (e.g., input possible)
* uname : get name and information about current kernel
* access, faccessat : check user's permissions for a file
* brk, sbrk : change data segment size
* mprotect : set protection on a region of memory
* read : read from a file descriptor
* close : close a file descriptor
* mmap, munmap : map or unmap files or devices into memory
* sigaction, rt_sigaction : examine and change a signal action
* open, openat, creat : open and possibly create a file
* stat, fstat, lstat, fstatat : get file status

## ressources :
http://man7.org/linux/man-pages/man2/syscalls.2.html 

