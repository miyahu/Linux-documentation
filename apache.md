### obtenir le status d'Apache en ligne de commande avec les explications

Ajouter '?auto' à la fin de l'url

`curl  "http://127.0.0.1:81/server-status?auto"`

Explication sur la sortie 

* Total Accesses: le total des requêtes servit depuis que le process principale est lancé 
* Total kBytes: le total des octets servit depuis que le process principale est lancé 
* CPULoad: charge CPU pour l'ensemble des processus
* Uptime: l'uptime
* ReqPerSec: nb de requête par secondes
* BytesPerSec: nb d'octets traités par secondes (global)
* BytesPerReq: nb d'octets traités par requête 
* BusyWorkers: nb de processus occupé à traiter les requêtes 
* IdleWorkers: nb de processus inactif

Je pense que l'important est principalement :
* ReqPerSec - si ce compteur s'incrémente rapidement
* IdleWorkers - si ce compteur se décrémente rapidement ou bien qu'il soit à zéro (situation critique)
* BusyWorkers - si ce compteur s'incrémente rapidement et qu'il tend vers le max client 
