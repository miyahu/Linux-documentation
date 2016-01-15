# Outils de troubleshooting système et réseau sous Linux

*Si tu donnes un poisson à un homme, il mangera un jour.*

*Si tu lui apprends à pêcher, il mangera toujours.*
                                          
### Il s'agit de méthodes d'analyse habituellement mises en oeuvres dans le but de corriger une anomalie de fonctionnement.

* le troubleshooting requiert de la part de l'analyste une base technique correct ainsi qu'une bonne intuition
* le troubleshooting ne s'apprend pas sur Internet (Stack overflow)
* le troubleshooting réseau nécessite de comprendre les protocoles à analyser, la lecture des RFC est donc, au bout d'un moment, un point de passage obligé.

### Nous n'étudierons pas spécifiquement ici les méthodes à utiliser pour le troubleshooting. 

### Chaque outil présenté, sera accompagné d'un petit lab de démonstration.  

Dans l'ordre, du plus simple au plus compliqué, nous étudierons :
* ps : de quelle manière lister les processus peut nous aider
* netstat : mieux comprendre les processus exposés sur le réseau
* lsof : quelles  ressources un programme utilise-t-il  ?
* strace : comment un programme interagit-t-il avec le système ? 
* tcpdump : comprendre les échanges réseau et la communication client/serveur



