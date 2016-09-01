* [bind logging](#bind-logging)

## bind logging

Add 

```
logging {
    channel query_log {
        severity    info;
        print-time  yes;
        file "/var/log/bind/query.log" versions 3 size 10M;
    };
    channel activity_log {
        severity        info;
        print-time      yes;
        print-category  yes;
        print-severity  yes;
        file "/var/log/bind/activity.log" versions 3 size 10M;
    };
    category queries         { query_log; };
    category default         { activity_log; };
    category xfer-in         { activity_log; };
    category xfer-out        { activity_log; };
    category notify          { activity_log; };
    category security        { activity_log; };
    category update          { activity_log; };
    category update-security { activity_log; }; # BIND 9.3 only
    category network         { null; };
    category lame-servers    { null; };
};
```
to 
```
/etc/bind/named.conf.logging
```
and add 

```
include "/etc/bind/named.conf.logging";
```
to
```
/etc/bind/named.conf
```

