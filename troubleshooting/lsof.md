#lsof

Niveau moyen

## Présentation

lsof permet de connaitre les éléments utilisés par un processus - par élément on entend les fichiers, les répertoires, les sockets et les descripteurs.

lsof s'utilise principalement pour effectuer du troubleshooting système et, dans une moindre mesure, du troubleshooting réseau ; un cas d'utilisation typique étant l'analyse post-piratage.

### Utilisation typique
* en cas de piratage, trouver les fichiers sources d'un processus écoutant sur un socket
* trouver les fichiers dépendant du processus ex log personnalisé
* regarder les libs chargée pour identifié le programme ex tomcat 

## Exemples d'utilisation

Quels processus utilisent le fichier /var/log/syslog ?

    fg25:~# lsof /var/log/syslog

Quels sont les fichiers ouverts par le processus de PID 3094 ?

```
    fg25:~# lsof -p 3094
    COMMAND  PID USER   FD   TYPE DEVICE    SIZE    NODE NAME
    sshd    3094 root  cwd    DIR    8,1    4096       2 /
    sshd    3094 root  rtd    DIR    8,1    4096       2 /
    sshd    3094 root  txt    REG    8,1  321328 1532308 /usr/sbin/sshd
```

 Quels sont les *sockets* réseaux ouverts par l'identifiant **www-data** ?

    fg25:~# lsof -ni 4 -a -u www-data
    COMMAND   PID     USER   FD   TYPE DEVICE SIZE NODE NAME
    php     15743 www-data    3u  IPv4 554042       TCP 223.182.58.229:38046->223.218.158.233:mysql (SYN_SENT)

Quelques explications

* l'option -a permet d'effectuer un ET logique sur les options
* dans cette exemple, on peut constater que l'utilisateur www-data n'écoute pas sur le port 80, c'est normal car par sécurité Apache écoute en root sur le port 80 et sert ensuite les clients en www-data, compte non privilégié

Quel processus écoute sur le *port* *tcp* *22* ?
```
    lsof -ni tcp:22
    COMMAND  PID USER   FD   TYPE DEVICE SIZE NODE NAME
    sshd    3094 root    3u  IPv6   7235       TCP *:ssh (LISTEN)
    sshd    8681 root    3u  IPv6  32581       TCP 213.282.158.229:ssh->213.228.137.221:34288 (ESTABLISHED)
```
Quel processus accède au répertoire */var/lib/* ?
```
    lsof +D /var/lib/
```
Quel sont les fichiers ouverts par les processus de l'utilisateur Apache
```
    lsof -u www-data
```
## Analyse de la sortie

```
fg25:~# lsof -nc munin-node 
COMMAND    PID USER   FD   TYPE DEVICE    SIZE    NODE NAME
munin-nod 3321 root  cwd    DIR    8,1    4096       2 /
munin-nod 3321 root  rtd    DIR    8,1    4096       2 /
munin-nod 3321 root  txt    REG    8,1 1061700 1540108 /usr/bin/perl
munin-nod 3321 root  mem    REG    0,0               0 [heap] (stat: No such file or directory)
munin-nod 3321 root  mem    REG    8,1   38372 1442019 /lib/tls/i686/cmov/libnss_files-2.3.6.so
munin-nod 3321 root  mem    REG    8,1   34320 1441973 /lib/tls/i686/cmov/libnss_nis-2.3.6.so
munin-nod 3321 root  mem    REG    8,1   76548 1441972 /lib/tls/i686/cmov/libnsl-2.3.6.so
munin-nod 3321 root  mem    REG    8,1   30428 1441801 /lib/tls/i686/cmov/libnss_compat-2.3.6.so
munin-nod 3321 root  mem    REG    8,1    5916 1526179 /usr/lib/perl/5.8.8/auto/Sys/Hostname/Hostname.so
munin-nod 3321 root  mem    REG    8,1   11784 1523806 /usr/lib/perl/5.8.8/auto/Fcntl/Fcntl.so
munin-nod 3321 root  mem    REG    8,1  111304 1523796 /usr/lib/perl/5.8.8/auto/POSIX/POSIX.so
munin-nod 3321 root  mem    REG    8,1   15640 1523778 /usr/lib/perl/5.8.8/auto/IO/IO.so
munin-nod 3321 root  mem    REG    8,1   21868 1441960 /lib/tls/i686/cmov/libcrypt-2.3.6.so
munin-nod 3321 root  mem    REG    8,1 1241392 1441958 /lib/tls/i686/cmov/libc-2.3.6.so
munin-nod 3321 root  mem    REG    8,1   89370 1442018 /lib/tls/i686/cmov/libpthread-2.3.6.so
munin-nod 3321 root  mem    REG    8,1  145136 1441957 /lib/tls/i686/cmov/libm-2.3.6.so
munin-nod 3321 root  mem    REG    8,1    9592 1441795 /lib/tls/i686/cmov/libdl-2.3.6.so
munin-nod 3321 root  mem    REG    8,1   19764 1523772 /usr/lib/perl/5.8.8/auto/Socket/Socket.so
munin-nod 3321 root  mem    REG    8,1   88164 5201938 /lib/ld-2.3.6.so
munin-nod 3321 root    0r   CHR    1,3            1103 /dev/null
munin-nod 3321 root    1w   CHR    1,3            1103 /dev/null
munin-nod 3321 root    2w   REG    8,1   16770  532647 /var/log/munin/munin-node.log
munin-nod 3321 root    3r   REG    8,1     784 4776242 /etc/munin/munin-node.conf
munin-nod 3321 root    4w   REG    8,1   16770  532647 /var/log/munin/munin-node.log
munin-nod 3321 root    5u  IPv4   7398             TCP *:munin (LISTEN)
```

* la première colone correspond à la commande lancée - ex /usr/sbin/sshd -D 
* la seconde au PID du processus - ex 1121
* la troisième à l'utilisateur du processus - ex www-data
* la quatrième au descripteur de fichier (point d'entrée de communication), ainsi qu'à son accès  - 1w correspond à la sortie standard ouvert en écriture 
* la cinquième correspond au type :

 * REG – fichier régulier
 * DIR – répertoire
 * FIFO – tube 
 * CHR – fichier de type caractère
* la sixième colone correspond à l'identifiant du périphérique (majeur et mineur) 
* la septième correspond à la taille mémoire de la ressource 
* la huitième correpond au numéro de l'inode de la ressource
* la neuvième correspond au nom de la ressource   

Le type de périphérique indique la manière dont les données sont écrites sur un périphérique. Pour un périphérique caractère, on parle d'écriture en série, octet par octet, alors que pour un périphérique bloc (par exemple, un disque dur), elle s'effectue sous forme de blocs d'octet (1)

## Exercices

Quelles sont les logs ouverts par le serveur apache ?

```
lsof -n -u www-data | grep log
```

et uniquement les logs d'erreur (fd 2)

```
fg25:~# lsof -n -u www-data -a -d w,2
COMMAND   PID     USER   FD   TYPE DEVICE SIZE    NODE NAME
apache2  3316 www-data    2w   REG    8,1  384 1124607 /var/log/apache2/error.log
apache2  3317 www-data    2w   REG    8,1  384 1124607 /var/log/apache2/error.log
apache2  3318 www-data    2w   REG    8,1  384 1124607 /var/log/apache2/error.log
apache2  3319 www-data    2w   REG    8,1  384 1124607 /var/log/apache2/error.log
apache2  3320 www-data    2w   REG    8,1  384 1124607 /var/log/apache2/error.log
php     13010 www-data    2w  FIFO    0,6        45279 pipe
```

1) http://ftp.traduc.org/doc-vf/gazette-linux/html/2006/125/lg125-B.html#lg125b-3.fr


