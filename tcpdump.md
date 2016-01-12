#tcpdump


```
francegalop25:~# tcpdump -i lo tcp and port 1025 -s0 -w /tmp/out.pcap &
francegalop25:~# netcat -l -p 1025 &
francegalop25:~# echo "pouet" | netcat -w 1 localhost 1025
```
Analyse
```
tcpdump -nr /tmp/out.pcap 
reading from file /tmp/out.pcap, link-type EN10MB (Ethernet)
14:48:13.864514 IP 127.0.0.1.53187 > 127.0.0.1.1025: S 2331260649:2331260649(0) win 32792 <mss 16396,sackOK,timestamp 4462404 0,nop,wscale 7>
14:48:13.864518 IP 127.0.0.1.1025 > 127.0.0.1.53187: S 2323811564:2323811564(0) ack 2331260650 win 32768 <mss 16396,sackOK,timestamp 4462404 4462404,nop,wscale 7>
14:48:13.864533 IP 127.0.0.1.53187 > 127.0.0.1.1025: . ack 1 win 257 <nop,nop,timestamp 4462404 4462404>
14:48:13.864569 IP 127.0.0.1.53187 > 127.0.0.1.1025: P 1:7(6) ack 1 win 257 <nop,nop,timestamp 4462404 4462404>
14:48:13.864576 IP 127.0.0.1.1025 > 127.0.0.1.53187: . ack 7 win 256 <nop,nop,timestamp 4462404 4462404>
14:48:15.864838 IP 127.0.0.1.53187 > 127.0.0.1.1025: F 7:7(0) ack 1 win 257 <nop,nop,timestamp 4462904 4462404>
14:48:15.864911 IP 127.0.0.1.1025 > 127.0.0.1.53187: F 1:1(0) ack 8 win 256 <nop,nop,timestamp 4462904 4462904>
14:48:15.864926 IP 127.0.0.1.53187 > 127.0.0.1.1025: . ack 2 win 257 <nop,nop,timestamp 4462904 4462904>
