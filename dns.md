* [analyse de requete dig](#analyse-de-requete-dig)
* [configuration de unbound](#configuration-de-unbound)
* [dnsperf](#dnsperf)

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
