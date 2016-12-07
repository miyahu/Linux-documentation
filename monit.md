* [ monit: error connecting to the monit daemon] (#monit:-error-connecting-to-the-monit-daemon)
* [obtenir des notifications email] (#obtenir-des-notifications-email)
* [surveiller un service réseau localhost] (#surveiller-un-service-réseau-localhost)

## monit: error connecting to the monit daemon

activer les fonctions réseau

```
 set httpd port 2812 and
    use address localhost  # only accept connection from localhost
    allow localhos
```

Vérification

```
tcpdump -nr /tmp/out.pcap port 2812
reading from file /tmp/out.pcap, link-type LINUX_SLL (Linux cooked)
11:03:39.196879 IP 127.0.0.1.6378 > 127.0.0.1.2812: Flags [S], seq 768319318, win 32792, options [mss 16396,sackOK,TS val 239178614 ecr 0,nop,wscale 7], length 0
11:03:39.196891 IP 127.0.0.1.2812 > 127.0.0.1.6378: Flags [S.], seq 2371008602, ack 768319319, win 32768, options [mss 16396,sackOK,TS val 239178614 ecr 239178614,nop,wscale 7], length 0
11:03:39.196899 IP 127.0.0.1.6378 > 127.0.0.1.2812: Flags [.], ack 1, win 257, options [nop,nop,TS val 239178614 ecr 239178614], length 0
11:03:39.197028 IP 127.0.0.1.6378 > 127.0.0.1.2812: Flags [P.], seq 1:49, ack 1, win 257, options [nop,nop,TS val 239178614 ecr 239178614], length 48
11:03:39.197040 IP 127.0.0.1.2812 > 127.0.0.1.6378: Flags [.], ack 49, win 256, options [nop,nop,TS val 239178614 ecr 239178614], length 0
11:03:39.197132 IP 127.0.0.1.2812 > 127.0.0.1.6378: Flags [P.], seq 1:18, ack 49, win 256, options [nop,nop,TS val 239178614 ecr 239178614], length 17
11:03:39.197155 IP 127.0.0.1.2812 > 127.0.0.1.6378: Flags [FP.], seq 18:863, ack 49, win 256, options [nop,nop,TS val 239178614 ecr 239178614], length 845
11:03:39.197176 IP 127.0.0.1.6378 > 127.0.0.1.2812: Flags [.], ack 18, win 257, options [nop,nop,TS val 239178614 ecr 239178614], length 0
11:03:39.197194 IP 127.0.0.1.6378 > 127.0.0.1.2812: Flags [.], ack 864, win 256, options [nop,nop,TS val 239178614 ecr 239178614], length 0
11:03:39.197347 IP 127.0.0.1.6378 > 127.0.0.1.2812: Flags [F.], seq 49, ack 864, win 256, options [nop,nop,TS val 239178614 ecr 239178614], length 0
11:03:39.197361 IP 127.0.0.1.2812 > 127.0.0.1.6378: Flags [.], ack 50, win 256, options [nop,nop,TS val 239178614 ecr 239178614], length 0
```

### obtenir des notifications email

Ajouter le mail server
```
set mailserver localhost
```

puis le compte de destination

```
set alert petit.cochon@atagada.fr
```

### surveiller un service réseau localhost 

Au hasard, un java ...  

```
cat  /etc/monit/conf.d/co-service-socket
check host co-service-socket with address 127.0.0.1
   start program = "/etc/init.d/co-services start" with timeout 60 seconds
   stop  program = "/etc/init.d/co-services stop"
   if failed host 127.0.0.1 port 9000 then restart
   if 5 restarts within 5 cycles then timeout
```
