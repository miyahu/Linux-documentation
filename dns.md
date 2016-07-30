*[analyse de requete dig](#analyse-de-requete-dig)
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

