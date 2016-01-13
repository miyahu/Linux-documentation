# ps

Niveau facile

## Présentation

## Utilisation typique
* connaître les services actifs
* connaître les dépendances et relations
* savoir quel processus consomme le plus de ressource
* savoir à qui appartient un processus 

Les processus entre crochets appartiennent au noyau.

```
francegalop25:~# ps auxf
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0   1948   640 ?        Ss   Jan12   0:01 init [2]  
root         2  0.0  0.0      0     0 ?        S    Jan12   0:00 [migration/0]
root         3  0.0  0.0      0     0 ?        SN   Jan12   0:00 [ksoftirqd/0]
root         4  0.0  0.0      0     0 ?        S    Jan12   0:00 [migration/1]
root         5  0.0  0.0      0     0 ?        SN   Jan12   0:00 [ksoftirqd/1]
root      2889  0.0  0.0   1624   640 ?        Ss   Jan12   0:00 /sbin/syslogd -m 0
nagios    2977  0.0  0.0   3400   996 ?        Ss   Jan12   0:00 /usr/sbin/nrpe -c /etc/nagios/nrpe.cfg -d
root      3064  0.0  0.0   4932  1108 ?        Ss   Jan12   0:00 /usr/sbin/sshd
root      3950  0.0  0.0   7860  2396 ?        Ss   Jan12   0:01  \_ sshd: root@pts/0 
root     30349  0.0  0.0   4076  1760 pts/1    Ss   09:55   0:00      \_ -bash
root     30355  0.0  0.0   3404   964 pts/1    R+   09:55   0:00          \_ ps auxf
proftpd   3115  0.0  0.0   9020  1508 ?        Ss   Jan12   0:00 proftpd: (accepting connections)
root      3269  0.0  0.0 154892  8300 ?        Ss   Jan12   0:00 /usr/sbin/apache2 -k start
www-data  3316  0.0  0.0 155028  5020 ?        S    Jan12   0:00  \_ /usr/sbin/apache2 -k start
www-data  3317  0.0  0.0 155028  5020 ?        S    Jan12   0:00  \_ /usr/sbin/apache2 -k start
www-data  3318  0.0  0.0 155028  5020 ?        S    Jan12   0:00  \_ /usr/sbin/apache2 -k start
www-data  3319  0.0  0.0 155028  5020 ?        S    Jan12   0:00  \_ /usr/sbin/apache2 -k start
www-data  3320  0.0  0.0 155028  5020 ?        S    Jan12   0:00  \_ /usr/sbin/apache2 -k start
```

