### faire du load balancing sur de la délégation de politique

utiliser http://postfwd.org/hapolicy/index.html 

### spf et dkim

https://www.linode.com/docs/email/postfix/configure-spf-and-dkim-in-postfix-on-debian-8

### vmail
```
useradd -m -d /var/spool/vmail -s /bin/false -u 999 -g vmail vmail
```

### stats sur postscreen

```
 python postscreen_stats.py -f /var/log/mail.log --geofile=../GeoLiteCity.dat --mapdest=/var/www/html/report.html
```
