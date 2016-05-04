### suivre les sessions

```
ipvsadm -Ln | head -n 6
IP Virtual Server version 1.2.1 (size=4096)
Prot LocalAddress:Port Scheduler Flags
  -> RemoteAddress:Port           Forward Weight ActiveConn InActConn
TCP  10.0.30.60:25 rr
  -> 10.0.30.30:25                Route   1      1          595       
  -> 10.0.30.64:25                Route   1      1          595
```  
