cat  /etc/ipsec.conf /var/lib/strongswan/ipsec.secrets.inc
# ipsec.conf - strongSwan IPsec configuration file

# basic configuration

config setup
        # strictcrlpolicy=yes
        # uniqueids = no

conn lenet-scal
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
37.16.21.7 212.47.22.4  PSK  "tag"

testing

ipsec statusall


+

pv4.ip_forward = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0

root@newtonlin:~# nmap -P0 -sU -p 500,4500   212.47.22.4

Starting Nmap 6.47 ( http://nmap.org ) at 2016-12-11 12:28 CET
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

## informations importantes

### les rôles 

* initiator (celui qui "propose" le tunnel je pense)
* responder

Le responder a des facilités pour debugger la connexion, à l'inverse de l'initiator

### les modes
 
* main mode (phase 1)
* quick mode (phase 2)

### les steps

http://www.ciscopress.com/articles/article.asp?p=24833&seqNum=6

http://ptgmedia.pearsoncmg.com/images/chap1_1587050331/elementLinks/01fig15.gif

###  SRX vers strongswan

generating IKE_AUTH response 1 [ N(INVAL_SYN) ou ipsec  ID INITIATOR  

Attention, les leftid et rightid correspondent au peer id, s'ils ne correspondent pas des deux côtés (strong et srx), le tunnel ne s'établit pas
commenter les left et rightid puis les remplacer par des Ip dans le fichier "secrets"

Conf côté strongswan

```
config setup
        
conn aahr
        left=33.50.201.25
        leftsubnet=10.0.22.0/24
        right=117.174.134.249
        rightsubnet=192.168.0.208/28
        ike=aes256-sha1-modp1024
        esp=3des-md5
        auto=start
        authby=secret
        keyexchange=ikev1
        ikelifetime=24h
        keylife=24h
        mobike=no
        rekey=yes
```


IKE : montage du tunnel
IPSEC : tunnel finaux

charondebug=all # ikev2
plutodebug=all # ikev1

strictcrlpolicy = yes ou no

## analyse du trafic (déencapsulation)

https://wiki.strongswan.org/projects/strongswan/wiki/CorrectTrafficDump

### strongswan 2 strongswan en host2host
```
conn tructruc
        leftid=@2exi.com
        right=192.154.235.164
        rightid=@ns42.tux.com
        auto=start
        ike=3des-md5-modp1024
        ikelifetime=28800s
        keyexchange=ikev2
        esp=3des-md5
```
et
~





