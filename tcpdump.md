#tcpdump

## présentation
Tcpdump permet de capturer le trafic en vue de, par exemple, l'analyser.

## Analyse

```
fg25:~# tcpdump -i lo tcp and port 1025 -s0 -w /tmp/out.pcap &
fg25:~# netcat -l -p 1025 &
fg25:~# echo "pouet" | netcat -w 1 localhost 1025
```
Analyse
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
