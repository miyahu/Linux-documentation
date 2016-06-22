* [tagada](#description)
* [obtenir le status d'Apache en ligne de commande avec les explications](#aveclynx)

## obtenir le status d'Apache en ligne de commande avec les explications

Ajouter '?auto' à la fin de l'url

`curl  "http://127.0.0.1:81/server-status?auto"`

#### Explication sur la sortie 

* Total Accesses: le total des requêtes servit depuis que le process principale est lancé 
* Total kBytes: le total des octets servit depuis que le process principale est lancé 
* CPULoad: charge CPU pour l'ensemble des processus
* Uptime: l'uptime
* ReqPerSec: nb de requête par secondes
* BytesPerSec: nb d'octets traités par secondes (global)
* BytesPerReq: nb d'octets traités par requête 
* BusyWorkers: nb de processus occupé à traiter les requêtes 
* IdleWorkers: nb de processus inactif

#### Je pense que l'important est principalement :
* ReqPerSec - si ce compteur s'incrémente rapidement
* IdleWorkers - si ce compteur se décrémente rapidement ou bien qu'il soit à zéro (situation critique)
* BusyWorkers - si ce compteur s'incrémente rapidement et qu'il tend vers le max client 

aveclynx 
--------

(c mieux) 
http://wiki.kogite.fr/index.php/Explication_server-status_Apache

apt-get install lynx

```
                                                                                                                                                                                                                     Apache Status (p1 of 5)
                                                                                                     Apache Server Status for 127.0.0.1                                                                                                     
                                                                                                                                                                                                                                            
   Server Version: Apache/2.2.22 (Debian) mod_fastcgi/mod_fastcgi-SNAP-0910052141 mod_ssl/2.2.22 OpenSSL/1.0.1e                                                                                                                             
   Server Built: Aug 18 2015 09:49:50                                                                                                                                                                                                       
     ______________________________________________________________________________________________________________________________________________________________________________________________________________________________         
                                                                                                                                                                                                                                            
   Current Time: Wednesday, 22-Jun-2016 10:31:54 CEST                                                                                                                                                                                       
   Restart Time: Wednesday, 22-Jun-2016 08:37:10 CEST                                                                                                                                                                                       
   Parent Server Generation: 2                                                                                                                                                                                                              
   Server uptime: 1 hour 54 minutes 44 seconds                                                                                                                                                                                              
   Total accesses: 27570 - Total Traffic: 81.1 MB                                                                                                                                                                                           
   CPU Usage: u325.31 s23.92 cu0 cs0 - 5.07% CPU load                                                                                                                                                                                       
   4 requests/sec - 12.1 kB/second - 3084 B/request                                                                                                                                                                                         
   7 requests currently being processed, 68 idle workers                                                                                                                                                                                    
                                                                                                                                                                                                                                            
................................................................                                                                                                                                                                            
................................................................                                                                                                                                                                            
____________W______W_____.......................................                                                                                                                                                                            
................................................................                                                                                                                                                                            
................................................................                                                                                                                                                                            
................................................................                                                                                                                                                                            
___________________W___W_.......................................                                                                                                                                                                            
................................................................                                                                                                                                                                            
_____W_____W______W______.......................................                                                                                                                                                                            
................................................................                                                                                                                                                                            
................................................................                                                                                                                                                                            
................................................................                                                                                                                                                                            
................................................................                                                                                                                                                                            
................................................................                                                                                                                                                                            
................................................................                                                                                                                                                                            
................................................................                                                                                                                                                                            
                                                                                                                                                                                                                                            
   Scoreboard Key:                                                                                                                                                                                                                          
   "_" Waiting for Connection, "S" Starting up, "R" Reading Request,                                                                                                                                                                        
   "W" Sending Reply, "K" Keepalive (read), "D" DNS Lookup,                                                                                                                                                                                 
   "C" Closing connection, "L" Logging, "G" Gracefully finishing,                                                                                                                                                                           
   "I" Idle cleanup of worker, "." Open slot with no current process                                                                                                                                                                        
                                                                                                                                                                                                                                            
   Srv  PID    Acc   M CPU    SS   Req  Conn Child Slot   Client         VHost                                  Request                                                                                                                     
   0-1 -     0/0/221 . 1.10  1265 134   0.0  0.00  0.66 10.0.157.11 pa2.nen.net POST /?rand=1466582957828 HTTP/1.1                                                                                                                      
   0-1 -     0/0/220 . 1.15  1265 47    0.0  0.00  0.68 10.0.157.11 pa2.nen.net GET / HTTP/1.1                                                                                                                                          
   0-1 -     0/0/218 . 1.12  1265 329   0.0  0.00  0.72 10.0.157.11 pa2.nen.net GET /themes/padd/css/fonts/fontawesome-webfont.eot HTTP/1.1                                                                                             
   0-1 -     0/0/220 . 1.13  1265 109   0.0  0.00  0.67 10.0.157.11 pa2.nen.net OPTIONS / HTTP/1.0                                                                                                                                      
   0-1 -     0/0/216 . 1.16  1265 2019  0.0  0.00  0.47 10.0.157.11 pa2.nen.net GET /modules/blocklayered/blocklayered-ajax.php?id_category_lay                                                                                         
   0-1 -     0/0/219 . 1.16  1265 147   0.0  0.00  0.57 10.0.157.11 pa2.nen.net GET /-home_default/blouson-equi-theme-csi-5-microfibres-enfant.                                                                                         
   0-1 -     0/0/217 . 0.92  1265 2914  0.0  0.00  0.58 10.0.157.11 pa2.nen.net GET /soldes?p=25 HTTP/1.1                                                                                                                               
   0-1 -     0/0/219 . 0.87  1265 51    0.0  0.00  0.64 10.0.157.13 pa2.nen.net GET / HTTP/1.1                                                                                                                                          
   0-1 -     0/0/218 . 0.90  1265 1362  0.0  0.00  0.78 10.0.157.11 pa2.nen.net GET /soldes?orderby=quantity&orderway=asc&orderway=asc&p=10 HTT                                                                                         
   0-1 -     0/0/219 . 0.91  1265 148   0.0  0.00  0.55 10.0.157.11 pa2.nen.net GET /themes/modules/productcomments/img/delete.gif HTTP/1.1                                                                                             
   0-1 -     0/0/217 . 0.90  1265 349   0.0  0.00  0.57 10.0.157.11 pa2.nen.net POST /?rand=1466583025682 HTTP/1.1                                                                                                                      
   0-1 -     0/0/218 . 0.93  1265 9     0.0  0.00  0.51 10.0.157.11 pa2.nen.net GET /modules/infrahabillage/img/habillage_left.jpg HTTP/1.1                                                                                             
   0-1 -     0/0/217 . 0.97  1265 164   0.0  0.00  0.70 10.0.157.11 pa2.nen.net POST /?rand=1466380800036 HTTP/1.1                                                                                                                      
   0-1 -     0/0/218 . 0.96  1265 1536  0.0  0.00  0.81 10.0.157.11 pa2.nen.net GET /soldes?p=26 HTTP/1.1 
   ```
#### explications
un slot est un processus

##### Titre des colones
* Srv  Child Server number - generation
* PID  OS process ID
* Acc  Number of accesses this connection / this child / this slot
* M   Mode of operation
* CPU  CPU usage, number of seconds
* SS   Seconds since beginning of most recent request 
* Req  Milliseconds required to process most recent request
* Conn  Kilobytes transferred this connection
* Child Megabytes transferred this child
* Slot  Total megabytes transferred this slot

description
-----------
