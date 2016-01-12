#lsof


lsof permet de savoir quels objets utilise un processus - par objets on entend fichiers, répertoires, sockets, descripteurs.

lsof s'utilise beaucoup lors du troubleshooting système et un peu lors du troubleshooting réseau, un cas d'utilisation typique l'analyse d'un piratage.

### Quels processus utilise le fichier /var/log/syslog ?

    lsof /var/log/syslog

### Quels sont les fichiers ouverts par le processus ?

```
    francegalop25:~# lsof -p 3094
    COMMAND  PID USER   FD   TYPE DEVICE    SIZE    NODE NAME
    sshd    3094 root  cwd    DIR    8,1    4096       2 /
    sshd    3094 root  rtd    DIR    8,1    4096       2 /
    sshd    3094 root  txt    REG    8,1  321328 1532308 /usr/sbin/sshd
```


### Quels sont les sockets TCP ouverts par un processus ?

    francegalop25:~# lsof -ni 4 -a -u www-data
    COMMAND   PID     USER   FD   TYPE DEVICE SIZE NODE NAME
    php     15743 www-data    3u  IPv4 554042       TCP 213.182.58.229:38046->213.218.148.233:mysql (SYN_SENT)

Question

Dans cette exemple, on peut constater que l'utilisateur www-data n'écoute pas sur le port 80, c'est normal car par sécurité Apache écoute en root sur le port 80 et sert ensuite les clients en www-data, compte non privilégié

### Quel processus à ouvert un socket sur le port 22 ?
    lsof -ni tcp:22
    COMMAND  PID USER   FD   TYPE DEVICE SIZE NODE NAME
    sshd    3094 root    3u  IPv6   7235       TCP *:ssh (LISTEN)
    sshd    8681 root    3u  IPv6  32581       TCP 213.182.58.229:ssh->213.218.130.221:34288 (ESTABLISHED)

### Quel processus accède à un répertoire ?
    lsof +D /var/lib/

### Quel sont les fichiers ouverts par les processus d'un utilisateur
    lsof -u www-data


2) Analyse de la sortie
