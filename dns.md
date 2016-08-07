* [analyse de requete dig](#analyse-de-requete-dig)
* [configuration de unbound](#configuration-de-unbound)
* [dnsperf](#dnsperf)
* [unbound avec dnstap](#unbound-avec-dnstap)
* [ressources](#ressources)

http://www.networksorcery.com/enp/protocol/dns.htm

## analyse de requete dig

```
dig @127.0.0.1 ahnlab.com

; <<>> DiG 9.9.5-9+deb8u6-Debian <<>> @127.0.0.1 ahnlab.com
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 47527
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 2, ADDITIONAL: 2

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;ahnlab.com.			IN	A

;; ANSWER SECTION:
ahnlab.com.		600	IN	A	211.233.80.53

;; AUTHORITY SECTION:
ahnlab.com.		600	IN	NS	nis.dacom.co.kr.
ahnlab.com.		600	IN	NS	ns2.dacom.co.kr.

;; ADDITIONAL SECTION:
nis.dacom.co.kr.	600	IN	A	164.124.101.31

;; Query time: 1357 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
;; WHEN: Sat Jul 30 13:10:35 CEST 2016
;; MSG SIZE  rcvd: 118
```
### Analyse de la section header

* opcode: QUERY - type, en l'occurence opcode 0 (type query) http://www.networksorcery.com/enp/protocol/dns.htm#Opcode
* status: NOERROR - status de la resquête ?? (à confirmer)
* id: 47527 http://www.networksorcery.com/enp/protocol/dns.htm#Identification
* flags: qr rd ra
* QUERY: 1
* ANSWER: 1
* AUTHORITY: 2
* ADDITIONAL: 2

## configuration de unbound
```
server:

        verbosity: 4
        statistics-interval: 60
        extended-statistics: "yes"
        statistics-cumulative: "yes"

        do-ip6: "no"
        do-udp: "yes"
        do-tcp: "yes"

        interface: 0.0.0.0
        access-control: 127.0.0.0/8 allow
        do-not-query-localhost: "no"


        #logfile: /var/log/unbound.log
        use-syslog: "yes"
        log-queries: "yes"

        prefetch: "yes"

        cache-min-ttl: 3600
        cache-max-ttl: 86400

        so-reuseport: "yes"
        msg-cache-size: 100m
        rrset-cache-size: 100m
        key-cache-size: 100m

        harden-dnssec-stripped: "no"
        disable-dnssec-lame-check: "yes"
        domain-insecure: "architux.com"


        # blacklist
        local-zone: "doubleclick.net" redirect
        local-data: "doubleclick.net A 127.0.0.1"
        local-zone: "googlesyndication.com" redirect
        local-data: "googlesyndication.com A 127.0.0.1"
        local-zone: "googleadservices.com" redirect
        local-data: "googleadservices.com A 127.0.0.1"
        local-zone: "google-analytics.com" redirect
        local-data: "google-analytics.com A 127.0.0.1"
        local-zone: "ads.youtube.com" redirect
        local-data: "ads.youtube.com A 127.0.0.1"
        local-zone: "adserver.yahoo.com" redirect
        local-data: "adserver.yahoo.com A 127.0.0.1"

        forward-zone:
                name: "architux.com"
                forward-addr: 8.8.8.8
        forward-zone:
                name: "."
                forward-addr: 195.154.236.164
                #forward-addr: 8.8.8.8
```
## dnsperf

http://nominum.com/measurement-tools/

`apt-get install libssl-dev libkrb5-dev libcap-dev libxml2-dev`
```
./configure
make
make install
```

récupération du sample de NDD
```
wget ftp://ftp.nominum.com/pub/nominum/dnsperf/data/queryfile-example-current.gz | gunzip -

```

lancement du bench

```
  dnsperf -d queryfile-example-current -s localhost

```

## unbound avec dnstap


### dépendances

Le paquet Debian Jessie classique ne supporte pas dnstap

#### Jessie backport 
```
cat /etc/apt/sources.list.d/backports.list
deb http://http.debian.net/debian jessie-backports main
deb-src http://http.debian.net/debian jessie-backports main
```
Téléchargement des sources
```
apt-get source unbound=1.5.9-1~bpo8+1
```

```
wget http://ftp.debian.org/debian/pool/main/f/fstrm/libfstrm-dev_0.3.0-1_amd64.deb
dpkg -i libfstrm-dev_0.3.0-1_amd64.deb

apt install libevent-dev \
            libevent-extra-2.0-5 \
            libevent-pthreads-2.0-5 \
            libevent-core-2.0-5 \
            protobuf-c-compiler \
            protobuf-compiler \
            build-essential \
            dh-make \
            bzr-builddeb \
```

## Ressources

* DNS Flood Detector : http://www.adotout.com/
* Forging DNS request/response : https://github.com/crondaemon/dines
* capturing DNS trafic : https://www.dns-oarc.net/tools/dnscap

* L'INDEX !!! : http://www.statdns.com/resources/
