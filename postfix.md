### faire du load balancing sur de la délégation de politique

utiliser http://postfwd.org/hapolicy/index.html 

### spf et dkim

https://www.linode.com/docs/email/postfix/configure-spf-and-dkim-in-postfix-on-debian-8

### vmail

```bash
useradd -m -d /var/spool/vmail -s /bin/false -u 999 -g vmail vmail
```

### stats sur postscreen

```bash
 python postscreen_stats.py -f /var/log/mail.log --geofile=../GeoLiteCity.dat --mapdest=/var/www/html/report.html
```


### Un antispam

facile !!!

#### côté Postfix

```bash
grep -E  ^header_checks /etc/postfix/main.cf
header_checks = pcre:/etc/postfix/header_checks
```

```bash
grep Spam /etc/postfix/header_checks
/facebook/i PREPEND X-Spam: Yes
/Au.*Vieux.*campeur/i PREPEND X-Spam: Yes
```

#### et côté sieve 

pour ce connecter

```bash
sieveshell --user=antonio --authname=antonio localhost
```

la règle

```bash
if header :contains ["X-Spam"] "yes"
{
    fileinto "INBOX.Spam";
    stop;
}
```

