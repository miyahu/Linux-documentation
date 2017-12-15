* [debugging] (#debugging)
* [comprendre le debug rsyslog] (#comprendre-le-debug-rsyslog)
* [troubleshooting] (#troubleshooting)
## debugging

`rsyslogd -dn`

### comprendre le debug rsyslog

Enfin , tentative de traduction plutôt


9334.743622755:imudp.c        : imudp: epoll_wait() returned with 1 fds
#### reception d'un message en udp distant (émission par logger -t solr: testlocal)
9334.743659737:imudp.c        : imudp: recvmmsg returned 1
#### donnée reçues 
9334.743665149:imudp.c        : recv(5,36),acl:1,msg:<5>Jan 16 13:22:14 solr:: testlocal
9334.743670733:imudp.c        : msg parser: flags 70, from '~NOTRESOLVED~', msg '<5>Jan 16 13:22:14 solr:: testlocal'
9334.743674158:imudp.c        : parse using parser list 0x1032d50 (the default list).
9334.743687584:imudp.c        : dropped NUL at very end of message
9334.743696877:imudp.c        : Parser 'rsyslog.rfc5424' returned -2160
9334.743701710:imudp.c        : Message will now be parsed by the legacy syslog parser (one size fits all... ;)).
9334.743705414:imudp.c        : Parser 'rsyslog.rfc3164' returned 0
9334.743708846:imudp.c        : imudp: recvmmsg returned -1
#### ajout à la queue
9334.743715889:imudp.c        : main Q: qqueueAdd: entry added, size now log 1, phys 1 entries
#### démarrage du worker
9334.743737433:imudp.c        : main Q: MultiEnqObj advised worker start

#### évaluation des conditions 
9334.744141324:main Q:Reg/w0  : if condition result is 0
9334.744145364:main Q:Reg/w0  :     IF
9334.744152110:main Q:Reg/w0  :         var 'syslogtag'
9334.744158234:main Q:Reg/w0  :       CONTAINS
9334.744162998:main Q:Reg/w0  :         string 'solr:'
9334.744170464:main Q:Reg/w0  : eval expr 0x10618a0, type 'CMP_CONTAINS'
9334.744172208:main Q:Reg/w0  : eval expr 0x1044980, type 'V[86]'
9334.744173859:main Q:Reg/w0  : rainerscript: var 4: 'solr:'
9334.744175443:main Q:Reg/w0  : eval expr 0x1044980, return datatype 'S'
9334.744177145:main Q:Reg/w0  : eval expr 0x10618a0, return datatype 'N'
#### correspondance trouvée
9334.744178713:main Q:Reg/w0  : if condition result is 1
9334.744180401:main Q:Reg/w0  :     ACTION 8 [builtin:omfile:?solre]
####  appel du omfile
9334.744185002:main Q:Reg/w0  : executing action 8
9334.744186855:main Q:Reg/w0  : Called action, logging to builtin:omfile
9334.744204245:main Q:Reg/w0  : dnscache: entry (nil) found
9334.744284760:main Q:Reg/w0  : action 8 is transactional - executing in commit phase
9334.744290015:main Q:Reg/w0  : wti 0x1083e70: we need to create a new action worker instance for action 8
9334.744296421:main Q:Reg/w0  : Action 8 transitioned to state: itx
9334.744298625:main Q:Reg/w0  :     STOP
9334.744302889:main Q:Reg/w0  : END batch execution phase, entering to commit phase
9334.744305190:main Q:Reg/w0  : actionCommitAll: action 0, state 0, nbr to commit 0 isTransactional 1
9334.744307137:main Q:Reg/w0  : actionCommitAll: action 1, state 0, nbr to commit 0 isTransactional 1
9334.744309063:main Q:Reg/w0  : actionCommitAll: action 8, state 1, nbr to commit 0 isTransactional 1
9334.744310948:main Q:Reg/w0  : doTransaction: have commitTransaction IF, using that, pWrkrInfo 0x10842c0
9334.744312850:main Q:Reg/w0  : entering actionCallCommitTransaction(), state: itx, actionNbr 8, nMsgs 1
#### logging to local 
9334.744314852:main Q:Reg/w0  : omfile: file to log to: /var/log/centralisation/2017/01/16/bst01/solr/2017-01-16-bst01-solr.log
9334.744653803:main Q:Reg/w0  : file stream 2017-01-16-bst01-solr.log params: flush interval 0, async write 0
9334.744664134:main Q:Reg/w0  : Added new entry 0 for file cache, file '/var/log/centralisation/2017/01/16/bst01/solr/2017-01-16-bst01-solr.log'.
9334.744666869:main Q:Reg/w0  : omfile: write to stream, pData->pStrm 0x7f38f000add0, lenBuf 46, strt data Jan 16 13:22:14 bst01 solr: : testlocal

9334.744670529:main Q:Reg/w0  : strm 0x7f38f000add0: file -1(2017-01-16-bst01-solr.log) flush, buflen 46
9334.744672813:main Q:Reg/w0  : strmPhysWrite, stream 0x7f38f000add0, len 46
9334.744679464:main Q:Reg/w0  : file '/var/log/centralisation/2017/01/16/bst01/solr/2017-01-16-bst01-solr.log' opened as #20 with mode 416
9334.744685322:main Q:Reg/w0  : strm 0x7f38f000add0: opened file '/var/log/centralisation/2017/01/16/bst01/solr/2017-01-16-bst01-solr.log' for WRITE as 20

### troubleshooting
#### pour les imfile
vérifier que rsyslog scrute le fichier :
Faire un losf dessus
```bash
lsof -np 2573
...
rsyslogd 2573 root    7r   REG              253,5        5        453 /var/log/mysql/mysql-error.log
rsyslogd 2573 root    8r   REG              253,5       15        452 /var/log/mysql/mysql.log
rsyslogd 2573 root    9r   REG              253,5        5        451 /var/log/mysql/mysql-slow.log
```
## exclure une facility 

Ajouter le nom de la *facility* suivi de ".none", exemple

```bash
*.=info;*.=notice;*.=warn;\
       auth.none,authpriv.none;\
       cron.none,daemon.none;\
       mail.none,news.none          -/var/log/messages
```

## terminologie 




