# ps

Niveau facile

## Présentation
La commande *ps* permet de lister les processus présents sur le système. 

## Utilisation typique
* connaître les services actifs
* connaître les dépendances et relations
* savoir quel processus consomme le plus de ressource
* savoir à qui appartient un processus 

## Exemple d'utilisation
Obtenir la liste de tous les processus du système avec affichage hiérarchisé 
```
fg25~# ps auxf
```
## Explication
Les processus entre crochets appartiennent au noyau.

La mémoire virtuelle est égale à la mémoire physique additionnée à la mémoire de débordement (swap) 

Explication sur le titre des colones :

* USER : identité du processus
* PID : identifiant du processus 
* %CPU : pourcentage CPU utilisé par le processus
* %MEM : pourcentage mémoire physique utilisée par le processus
* VSZ : mémoire virtuelle utilisée par le processus
* RSS : mémoire physique utilisée par le processus
* TTY : console, apparaît quand le processus est lié à un terminal
* STAT : état du processus, par exemple en attente (sleep), en cours d'execution sur le CPU (R) etc ...
* START : âge du processus
* TIME : temps CPU cumulé - très utile pour connaître le processus consommant du CPU
* COMMAND : commande executée

### Analyse de la sortie
```
fg25:~# ps auxf
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
On peut constater que :

* le processus de PID 30355 (ps auxf) est en cours d'utilisation CPU (R+)
* le processus de PID 3950 à consommé 0:01 de temps CPU cumulé
* les processus 30349 (bash) et 30350 (ps auxf) sont effectivement rattachés à un terminal
