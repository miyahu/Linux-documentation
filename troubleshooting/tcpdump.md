#tcpdump

Niveau moyen

## Présentation
Tcpdump permet de capturer le trafic réseau en vue de, par exemple, l'analyser.

La lecture des RFC TCP, IPV4 et HTTP est généralement un bon pré-requis à la compréhension d'un dump.

## Utilisation typique
* anomalie réseau - pas de connexion vers untel
* comportement des services orientés réseau - **zero size reply** après une requête par exemple
* détection de problème de performance - multiples petites requêtes au lieu de plus grosses et moins fréquentes
* détection de flux non attendu - détection de services inconnus ou piratés 
 
## Exemples d'utilisation
Capturer dans **un fichier** (-w /tmp/out.pcap) **l'intégralité** (-s0) des paquets **tcp** transitants entre **192.168.0.1 et l'host local** à destination du **port 80**   
```
fg25:~# tcpdump -vi any tcp and host 192.168.0.1 and port 80 -s0 -w /tmp/out.pcap 
```
Lire un dump avec le contenu des paquets 
```
fg25:~# tcpdump -Anr /tmp/out.pcap 
```
Lire un dump avec juste le résumé des échanges   
```
fg25:~# tcpdump -nr /tmp/out.pcap 
```
## Premier lab de démonstration
### Analyse "de surface" d'un dump
Dans ce petit lab, nous tenterons de nous connecter sur un service réseau inexistant.
```
fg25:~# tcpdump -i lo tcp and port 1025 -w /tmp/out.pcap  &                                                                                                                          
[1] 14545
fg25:~# tcpdump: listening on lo, link-type EN10MB (Ethernet), capture size 96 bytes

fg25:~# echo "pouet" | netcat -w 1 localhost 1025
localhost [127.0.0.1] 1025 (?) : Connection refused
```
### Analyse
```
francegalop25:~# tcpdump -nr /tmp/out.pcap 
reading from file /tmp/out.pcap, link-type EN10MB (Ethernet)
13:22:09.959691 IP 127.0.0.1.55775 > 127.0.0.1.1025: S 3241574427:3241574427(0)
win 32792 <mss 16396,sackOK,timestamp 46371390 0,nop,wscale 7>
13:22:09.959730 IP 127.0.0.1.1025 > 127.0.0.1.55775: R 0:0(0) ack 3241574428 win 0
```
1. le client **netcat** attaque le port 1025 en localhost (drapeau S) 
2. aucun service n'écoutant, c'est la pile TCP du système qui renvoi un RESET

Remarque intéressante :
* généralement, et contrairement à notre exemple, un firewall "dropperais" la connexion en ne renvoyant rien - attention, dans de rare cas, certains firewall **reset** la connexion ex iptables avec "j REJECT --reject-with tcp-reset"
* aucune donnée utile n'ayant été échangée, remarquez la taille de 0 des paquets   

## Second lab de démonstration
### Analyse appronfondie d'un dump
```
fg25:~# tcpdump -i lo tcp and port 1025 -s0 -w /tmp/out.pcap &
fg25:~# netcat -l -p 1025 &
fg25:~# echo "pouet" | netcat -w 1 localhost 1025
```
### Analyse
```
fg25:~# tcpdump -Anr /tmp/out.pcap 
reading from file /tmp/out.pcap, link-type EN10MB (Ethernet)
14:48:13.864514 IP 127.0.0.1.53187 > 127.0.0.1.1025: S 2331260649:2331260649(0)
 win 32792 <mss 16396,sackOK,timestamp 4462404 0,nop,wscale 7>
..............6..........b....@....
.D.D........
```
le client se connect en localhost sur le port 25 avec le flag SYN
```
14:48:13.864518 IP 127.0.0.1.1025 > 127.0.0.1.53187: S 2323811564:2323811564(0)
 ack 2331260650 win 32768 <mss 16396,sackOK,timestamp 4462404 4462404,nop,wscale 7>
E..<..@.@.<...................6......r....@....
.D.D.D.D....
```
le serveur répond par un SYN,ACK au client
```
14:48:13.864533 IP 127.0.0.1.53187 > 127.0.0.1.1025: . ack 1 win 257 
<nop,nop,timestamp 4462404 4462404>
E..4!.@.@.................6................
.D.D.D.D
```
le client acquite 

Fin de la three Way Handshack
```
14:48:13.864569 IP 127.0.0.1.53187 > 127.0.0.1.1025: P 1:7(6) ack 1 win 257 
<nop,nop,timestamp 4462404 4462404>
..............6................
.D.D.D.Dpouet
```
le client envoi la string "pouet" au serveur (6 octets) et demande la remontée à la pile applicative (p = push) 
```
14:48:13.864576 IP 127.0.0.1.1025 > 127.0.0.1.53187: . ack 7 win 256 
<nop,nop,timestamp 4462404 4462404>
E..4..@.@.....................6............
.D.D.D.D
```
le serveur acquite 
```
14:48:15.864838 IP 127.0.0.1.53187 > 127.0.0.1.1025: F 7:7(0) ack 1 win 257 
<nop,nop,timestamp 4462904 4462404>
E..4!.@.@.................6................
.D.8.D.D
```
le client demande à fermer la connection (FIN) 
```
14:48:15.864911 IP 127.0.0.1.1025 > 127.0.0.1.53187: F 1:1(0) ack 8 win 256 
<nop,nop,timestamp 4462904 4462904>
E..4..@.@.....................6............
.D.8.D.8
```
le serveur demande à fermer la connection (FIN) et acquite la demande du client (ACK) 
```
14:48:15.864926 IP 127.0.0.1.53187 > 127.0.0.1.1025: . ack 2 win 257 
<nop,nop,timestamp 4462904 4462904>
E..4!.@.@.................6................
.D.8.D.8
```
le client acquite 
```
