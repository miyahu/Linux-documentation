* [couteau suisse smtp] 
* 
* tester la validitée des d'un smtp 


### couteau suisse smtp

Pour effectuer des tests, utiliser swaks

exemple pout debugger un problème

```
 swaks --to sarg@architux.com --server smtp2.architux.com
=== Trying smtp2.architux.com:25...
=== Connected to smtp2.architux.com.
<-  220 ESMTP POSTFIX
 -> EHLO on.way.fr
<-  250-architux.com
<-  250-PIPELINING
<-  250-SIZE 153600000
<-  250-VRFY
<-  250-ETRN
<-  250-STARTTLS
<-  250-AUTH PLAIN LOGIN
<-  250-AUTH=PLAIN LOGIN
<-  250-ENHANCEDSTATUSCODES
<-  250-8BITMIME
<-  250 DSN
 -> MAIL FROM:<root@on.way.fr>
<-  250 2.1.0 Ok
 -> RCPT TO:<sar@architux.com>
<** 450 4.1.1 <sar@architux.com>: Recipient address rejected: User unknown in local recipient table
 -> QUIT
<-  221 2.0.0 Bye
=== Connection closed with remote host.
```

### Postfix

From : http://www.linuxlasse.net/linux/howtos/Blacklist_and_Whitelist_with_Postfix

check_client__restrictions
Blocks by client IP, Client IP Range or Hostname 

smtpd_helo_restrictions
Blocks by ehlo Hostname

check_sender__restrictions
Block by sender e-mail address (In the FROM field) 

smtpd_recipient_restrictions
Block by sender e-mail address (In the RECP field) 

### http://www.appmaildev.com/en/dkim

http://www.appmaildev.com/en/dkim
