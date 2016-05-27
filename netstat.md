### comprendre le backlog

http://veithen.github.io/2014/01/01/how-tcp-backlog-works-in-linux.html

Le backlog se détecte lorsque des connexions sont mises en attente d'établissement

```
netstat -antp | grep SYN_RECV | wc -l
125
```
```
netstat -antp | grep SYN_RECV | head -n 10
tcp        0      0 10.0.16.21:80           77.234.43.186:65420     SYN_RECV    -               
tcp        0      0 10.0.16.21:80           89.170.181.15:57375     SYN_RECV    -               
tcp        0      0 10.0.16.21:80           90.45.38.190:57168      SYN_RECV    -               
tcp        0      0 10.0.16.21:80           81.66.137.185:49926     SYN_RECV    -               
tcp        0      0 10.0.16.21:80           31.33.248.51:50602      SYN_RECV    -               
tcp        0      0 10.0.16.21:80           78.118.238.136:42138    SYN_RECV    -               
tcp        0      0 10.0.16.21:80           204.237.174.22:37468    SYN_RECV    -               
tcp        0      0 10.0.16.21:80           86.209.18.14:58922      SYN_RECV    -               
tcp        0      0 10.0.16.21:80           109.221.141.142:63756   SYN_RECV    -               
tcp        0      0 10.0.16.21:80           2.0.203.104:55205       SYN_RECV    -
```
