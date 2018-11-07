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


include /var/lib/strongswan/ipsec.secrets.inc
37.16.21.7 212.47.22.4 : PSK  "passphrase"

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

## Strongswan for routing all trafic transparently for road warrior clients

Il s'agit d'un simili *split tunneling* sans ip virtuel.

Nous utiliserons ikev2 (pourquoi pas ?)

Ressources :

* https://wiki.strongswan.org/projects/strongswan/wiki/ForwardingAndSplitTunneling
* https://wiki.strongswan.org/projects/strongswan/wiki/RouteBasedVPN
* https://wiki.strongswan.org/issues/2355

### quelques bases

```bash
~# ipsec start 
~# ipsec stop
~# ipsec reload 
~# ipsec status
~# ipsec statusall
```

### regardons les porcs..

Vérifier que les ports *ipsec* soient bien accessibles côté serveur.

* udp/4500
* udp/500

Testez avec *nmap -sU -P0 "n° de port" "adresse"*

Si le status est *open/filtered*, c'est bon, c'est normal, c'est udp ^^

#### exemple

```bash
~# nmap -P0 -sU -p 500,4500   212.4.2.4

Starting Nmap 6.47 ( http://nmap.org ) at 2016-12-11 12:28 CET
Host is up (1.3s latency).
PORT     STATE         SERVICE
500/udp  open          isakmp
4500/udp open|filtered nat-t-ike
```

### gateway config

```bash
cat /etc/ipsec.conf
config setup
  charondebug="ike 1, knl 1, cfg 0"
  uniqueids=no

conn ikev2-vpn
    authby=secret
    auto=start
    compress=no
    type=tunnel
    keyexchange=ikev2
    fragmentation=yes
    forceencaps=yes
    ike=aes256-sha1-modp1024,3des-sha1-modp1024!
    esp=aes256-sha1,3des-sha1!
    dpdaction=clear
    dpddelay=300s
    rekey=no
    left=163.172.21.190
	  # ne pas spécifier les réseaux utilisables en phase 2, c'est autoriser l'accès vers tous.
    leftsubnet=%dynamic,0.0.0.0/0
    leftfirewall=yes
    right=%any
    rightsubnet=192.168.0.0/16
```

leftfirewall : demande à strongwan de charger les règles de FORWARD (pour faire la passerelle).

### le secret

```bash
~# cat /var/lib/strongswan/ipsec.secrets.inc
163.172.21.190 : PSK "cumulonimbus"
```

On ne spécifie pas de *right side* car on attends des *road warriors*.

Attention à bien garder un espace entre l'adresse ip et le **:** 

### iptables première partie

Deux règles, une d'entrée, une autre forward ont été automatiquement ajoutées (ne pas le faire manuellement):

```bash
-A FORWARD -s 192.168.0.0/16 -i eth0 -m policy --dir in --pol ipsec --reqid 7 --proto esp -j ACCEPT
# pourquoi reqid 2 ??
-A INPUT -s 192.168.0.0/16 -d 163.172.21.190/32 -i eth0 -m policy --dir in --pol ipsec --reqid 2 --proto esp -j ACCEPT
```

### Le routage

Pensez à activer le transfert entre interface 

```bash
sysctl net.ipv4.conf.all.forwarding=1
```

La table de routage ipsec est vide sur la gateway

```bash
root@ns7:~# ip route show table 220
root@ns7:~#
```

### iptables - seconde partie

#### ajout du nat qui permettra la navigation des clients VPN (sinon pas d'internet avec une ip privée).

*Strongswan* ne NAT pas de base, donc les paquets des clients viendront de l'adresse définie dans la rightsubnet (192.168.0.0/16).

```bash
-A POSTROUTING -s 192.168.0.0/16 -j MASQUERADE


### client config

```bash
cat /etc/ipsec.conf
config setup
  charondebug="ike 1, knl 1, cfg 0"
  uniqueids=no

conn ikev2-vpn
    authby=secret
    auto=start
    compress=no
    type=tunnel
    keyexchange=ikev2
    fragmentation=yes
    forceencaps=yes
    ike=aes256-sha1-modp1024,3des-sha1-modp1024!
    esp=aes256-sha1,3des-sha1!
    dpdaction=clear
    dpddelay=300s
    rekey=no

    left=%defaultroute
    # à changer dans ipsec.secrets.inc
    leftsubnet=0.0.0.0/0

    right=163.172.21.190
	  rightsubnet=0.0.0.0/0
```

#### le secret

```bash
cat /var/lib/strongswan/ipsec.secrets.inc 
192.168.11.5 163.172.21.190 : PSK  "cumulonimbus"
```
J'ai mis l'ip du *leftside*, il y a moyen de ne pas le faire, chercher la syntaxe peut-être

```bash
: 163.172.21.190 : PSK  "cumulonimbus"
```

#### iptables 

Le faire manuellement en l'ajoutant à */etc/iptables/rules.v4* puis en rechargeant avec *service netfilter-persistent restart*

```bash
-A POSTROUTING -s 192.168.0.0/16 -m policy --dir out --pol ipsec -j ACCEPT
-A POSTROUTING -s 192.168.0.0/16 -j MASQUERADE
```

#### le routage

```bash
~# ip route show table 220
default via 192.168.11.1 dev wlx3476c5b50cd3 proto static src 192.168.11.5
```

#### status du tunnel

```bash
~# ipsec statusall
Status of IKE charon daemon (strongSwan 5.5.1, Linux 4.8, x86_64):
  uptime: 6 minutes, since Oct 12 15:39:01 2018
  malloc: sbrk 2433024, mmap 0, used 415152, free 2017872
  worker threads: 11 of 16 idle, 5/0/0/0 working, job queue: 0/0/0/0, scheduled: 2
  loaded plugins: charon aes rc2 sha2 sha1 md5 random nonce x509 revocation constraints pubkey pkcs1 pkcs7 pkcs8 pkcs12 pgp dnskey sshkey pem openssl fips-prf gmp agent xcbc hmac gcm attr kernel-netlink resolve socket-default connmark stroke updown
Listening IP addresses:
  192.168.11.5
Connections:
   ikev2-vpn:  %any...163.172.21.190  IKEv2, dpddelay=300s
   ikev2-vpn:   local:  uses pre-shared key authentication
   ikev2-vpn:   remote: [163.172.21.190] uses pre-shared key authentication
   ikev2-vpn:   child:  0.0.0.0/0 === 0.0.0.0/0 TUNNEL, dpdaction=clear
Security Associations (1 up, 0 connecting):
   ikev2-vpn[1]: ESTABLISHED 5 minutes ago, 192.168.11.5[192.168.11.5]...163.172.21.190[163.172.21.190]
   ikev2-vpn[1]: IKEv2 SPIs: 0e57d24a4593df13_i* 6d1ead2b739c3d9d_r, rekeying disabled
   ikev2-vpn[1]: IKE proposal: AES_CBC_256/HMAC_SHA1_96/PRF_HMAC_SHA1/MODP_1024
   ikev2-vpn{1}:  INSTALLED, TUNNEL, reqid 1, ESP in UDP SPIs: c47269eb_i c8e29858_o
   ikev2-vpn{1}:  AES_CBC_256/HMAC_SHA1_96, 21508 bytes_i (196 pkts, 4s ago), 80987 bytes_o (281 pkts, 9s ago), rekeying disabled
   ikev2-vpn{1}:   192.168.0.0/16 === 0.0.0.0/0
```

On peut voir que côté client, la phase 2 est conforme (gauche restreint, droite ouverte)

```bash
192.168.0.0/16 === 0.0.0.0/0
```

** côté xfrm **

Vérifiez que les *policy* soient chargées

```bash
~# ip xfrm policy
src 0.0.0.0/0 dst 192.168.0.0/16 
	dir fwd priority 195904 ptype main 
	tmpl src 163.172.21.190 dst 192.168.11.5
		proto esp reqid 1 mode tunnel
src 0.0.0.0/0 dst 192.168.0.0/16 
	dir in priority 195904 ptype main 
	tmpl src 163.172.21.190 dst 192.168.11.5
		proto esp reqid 1 mode tunnel
src 192.168.0.0/16 dst 0.0.0.0/0 
	dir out priority 195904 ptype main 
	tmpl src 192.168.11.5 dst 163.172.21.190
		proto esp reqid 1 mode tunnel
```

##### vérification

**avec curl**

Faite un curl ifconfig.io pour valider que l'ip de sortie ai changée

Sans tunnel

```bash
~# curl ifconfig.io
180.14.50.49
```

Avec tunnel

```bash
~# curl ifconfig.io
163.172.21.190
```

#### avec traceroute

##### sans tunnel 

```bash
~# traceroute  free.fr
traceroute to free.fr (212.27.48.10), 30 hops max, 60 byte packets
 1  gateway (192.168.11.1)  3.808 ms  3.795 ms  3.845 ms
 2  153.153.217.239 (153.153.217.239)  46.714 ms  47.123 ms  47.833 ms
 3  153.153.217.117 (153.153.217.117)  48.505 ms  48.583 ms  49.037 ms
 4  153.153.223.137 (153.153.223.137)  50.351 ms  51.562 ms  52.489 ms
 5  180.8.126.49 (180.8.126.49)  51.947 ms  54.388 ms  54.586 ms
 6  60.37.54.77 (60.37.54.77)  55.539 ms 122.1.245.57 (122.1.245.57)  54.694 ms 60.37.54.77 (60.37.54.77)  22.552 ms
 7  ae-6.r02.tokyjp05.jp.bb.gin.ntt.net (120.88.53.21)  36.131 ms ae-5.r02.tokyjp05.jp.bb.gin.ntt.net (120.88.53.17)  36.283 ms ae-6.r02.tokyjp05.jp.bb.gin.ntt.net (120.88.53.21)  36.095 ms
 8  ae-3.r31.tokyjp05.jp.bb.gin.ntt.net (129.250.3.29)  36.304 ms  36.380 ms ae-4.r31.tokyjp05.jp.bb.gin.ntt.net (129.250.3.57)  36.454 ms
 9  ae-4.r23.lsanca07.us.bb.gin.ntt.net (129.250.3.193)  144.452 ms ae-4.r23.snjsca04.us.bb.gin.ntt.net (129.250.5.78)  149.234 ms  149.934 ms
10  ae-41.r02.snjsca04.us.bb.gin.ntt.net (129.250.6.119)  149.053 ms  149.215 ms ae-2.r00.lsanca07.us.bb.gin.ntt.net (129.250.3.238)  149.428 ms
11  be3025.ccr41.lax04.atlas.cogentco.com (154.54.9.29)  149.364 ms ae-0.cogent.snjsca04.us.bb.gin.ntt.net (129.250.8.42)  149.078 ms  138.223 ms
12  be3360.ccr42.lax01.atlas.cogentco.com (154.54.25.149)  133.148 ms  133.624 ms  134.699 ms
13  be2932.ccr32.phx01.atlas.cogentco.com (154.54.45.161)  154.421 ms be3109.ccr21.slc01.atlas.cogentco.com (154.54.44.138)  158.994 ms be2932.ccr32.phx01.atlas.cogentco.com (154.54.45.161)  155.526 ms
14  be3037.ccr21.den01.atlas.cogentco.com (154.54.41.146)  192.061 ms be2930.ccr21.elp01.atlas.cogentco.com (154.54.42.78)  172.149 ms  172.254 ms
15  be2928.ccr42.iah01.atlas.cogentco.com (154.54.30.161)  181.886 ms be3036.ccr22.mci01.atlas.cogentco.com (154.54.31.90)  185.032 ms  187.006 ms
16  be2687.ccr41.atl01.atlas.cogentco.com (154.54.28.69)  198.453 ms be2831.ccr41.ord01.atlas.cogentco.com (154.54.42.166)  183.274 ms  184.225 ms
17  be2113.ccr42.dca01.atlas.cogentco.com (154.54.24.221)  213.470 ms be2112.ccr41.dca01.atlas.cogentco.com (154.54.7.157)  217.467 ms be2717.ccr21.cle04.atlas.cogentco.com (154.54.6.222)  193.232 ms
18  be2879.ccr22.alb02.atlas.cogentco.com (154.54.29.174)  217.204 ms  217.189 ms  217.256 ms
19  * * be3599.ccr31.bos01.atlas.cogentco.com (66.28.4.238)  213.176 ms
20  be2983.ccr42.lon13.atlas.cogentco.com (154.54.1.177)  264.150 ms be3518.agr21.par01.atlas.cogentco.com (130.117.50.42)  267.664 ms be2983.ccr42.lon13.atlas.cogentco.com (154.54.1.177)  264.875 ms
21  be12489.ccr42.par01.atlas.cogentco.com (154.54.57.70)  284.573 ms be12497.ccr41.par01.atlas.cogentco.com (154.54.56.130)  280.399 ms 149.14.152.218 (149.14.152.218)  280.850 ms
22  be3517.agr21.par01.atlas.cogentco.com (130.117.49.42)  299.161 ms * *
23  bzn-9k-4-be1004.intf.routers.proxad.net (78.254.249.2)  288.230 ms  283.075 ms  283.993 ms
24  bzn-9k-2-sys-be2000.intf.routers.proxad.net (194.149.161.242)  290.193 ms 194.149.166.61 (194.149.166.61)  281.349 ms bzn-9k-2-sys-be2000.intf.routers.proxad.net (194.149.161.242)  268.180 ms
25  bzn-9k-4-be1004.intf.routers.proxad.net (78.254.249.2)  275.950 ms  276.006 ms  276.455 ms
26  www.free.fr (212.27.48.10)  287.651 ms  289.589 ms bzn-9k-2-sys-be2000.intf.routers.proxad.net (194.149.161.242)  278.422 ms
```

##### Avec tunnel

```bash
~# traceroute  free.fr
traceroute to free.fr (212.27.48.10), 30 hops max, 60 byte packets
 1  gruik.com (163.172.21.190)  303.872 ms  303.882 ms  303.890 ms
 2  * 163-172-214-1.rev.poneytelecom.eu (163.172.21.1)  307.041 ms  307.449 ms
 3  195.154.2.128 (195.154.2.128)  310.245 ms  310.140 ms  310.194 ms
 4  51.158.8.26 (51.158.8.26)  310.511 ms  310.947 ms 51.158.8.24 (51.158.8.24)  311.259 ms
 5  195.154.2.103 (195.154.2.103)  320.219 ms 195.154.2.105 (195.154.2.105)  324.747 ms  323.479 ms
 6  195.154.3.208 (195.154.3.208)  326.246 ms bzn-crs16-1-be1500-t.intf.routers.proxad.net (212.27.58.49)  310.686 ms  305.905 ms
 7  194.149.166.61 (194.149.166.61)  307.016 ms 194.149.166.37 (194.149.166.37)  306.837 ms 194.149.166.61 (194.149.166.61)  310.639 ms
 8  bzn-9k-4-be1004.intf.routers.proxad.net (78.254.249.2)  309.878 ms  310.778 ms  310.596 ms
 9  bzn-9k-2-sys-be2000.intf.routers.proxad.net (194.149.161.242)  310.008 ms  310.828 ms  310.009 ms
10  bzn-9k-2.sys.routers.proxad.net (212.27.32.146)  310.081 ms  312.142 ms  313.356 ms
11  www.free.fr (212.27.48.10)  313.270 ms  312.277 ms  311.733 ms
```
