cat  /etc/ipsec.conf /var/lib/strongswan/ipsec.secrets.inc
# ipsec.conf - strongSwan IPsec configuration file

# basic configuration

config setup
        # strictcrlpolicy=yes
        # uniqueids = no

conn levesinet-scalway
 authby=secret
 left=37.16.21.7
 leftsubnet=10.1.0.0/16
 right=212.47.22.4
 rightsubnet=10.2.0.0/16
 auto=start
 ## phase 1 ##
 keyexchange=ike
 ## phase 2 ##
 esp=3des-md5
 pfs=yes
 type=tunnel


include /var/lib/strongswan/ipsec.conf.inc
37.16.21.7 212.47.22.4  PSK  "tagada"

testing

ipsec statusall


+

pv4.ip_forward = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0

root@newtonlin:~# nmap -P0 -sU -p 500,4500   212.47.22.4

Starting Nmap 6.47 ( http://nmap.org ) at 2016-12-11 12:28 CET
Nmap scan report for 48-228-47-212.rev.cloud.scaleway.com (212.47.22.4)
Host is up (1.3s latency).
PORT     STATE         SERVICE
500/udp  open          isakmp
4500/udp open|filtered nat-t-ike

Nmap done: 1 IP address (1 host up) scanned in 9.85 seconds
root@newtonlin:~# netstat -lnup | grep charon
udp        0      0 0.0.0.0:4500            0.0.0.0:*                           14783/charon    
udp        0      0 0.0.0.0:500             0.0.0.0:*                           14783/charon    
udp6       0      0 :::4500                 :::*                                14783/charon    
udp6       0      0 :::500                  :::*                                14783/charon


### doc
http://linoxide.com/how-tos/ipsec-vpn-gateway-gateway-using-strongswan/
