# letsencrypt


## acmetool

acmetool status pour voir les chemins et d'éventuel erreur

### renouvellement

```bash
/usr/bin/acmetool want mail.architux.com webmail.archi.com opendns.com imap.archi.com
```
### le challenge dns

https://opportunis.me/letsencrypt-dns-challenge/

https://serverfault.com/questions/750902/how-to-use-lets-encrypt-dns-challenge-validation

en premier lieu, le lancer à la main 

```bash
certbot -d www.mugairyu.fr --manual --preferred-challenges dns certonly
```

puis déployer l'enregistrement TXT donné sur les serveurs DNS

recharger et vérifier

```bash
dig -t TXT _acme-challenge.www.mugairyu.fr @163.172.214.190
```


## dehydrated 

### tests

Pour tester, sans galérer avec le rate limit

Mettre la CA de test dans la config

```bash
CA="https://acme-staging-v02.api.letsencrypt.org/directory"
```

Puis lancer le test

```bash
dehydrated -x -c --config /etc/dehydrated/config-staging
```

### dehydrated, wildcard et challenge dns pour knot

#### doc 

> https://opportunis.me/letsencrypt-dns-challenge/

#### la config 

```bash
cat /etc/dehydrated/config                                                                                                                                                                                                         
BASEDIR=/var/lib/dehydrated
WELLKNOWN="${BASEDIR}/acme-challenges"
DOMAINS_TXT="/etc/dehydrated/domains.txt"
CONTACT_EMAIL="antonio@architux.com"
CHALLENGETYPE="dns-01"
HOOK=/etc/dehydrated/hooks/knot.sh
```

#### les domaines

```bash
cat /etc/dehydrated/domains.txt
*.architux.com > archituxcom
*.kartooch.com > kartoochcom
*.mugairyu.fr > mugairyufr
*.opendns.io > opendnsio
```

#### le hook

```bash
cat /etc/dehydrated/hooks/knot.sh
#!/usr/bin/env bash

set -e
set -u
set -o pipefail

NSUPDATE="knsupdate -k /etc/letsencrypt/scripts/knot.key"
DNSSERVER="127.0.0.1 5353"
TTL=1

case "$1" in
    "deploy_challenge")
        echo -e "server $DNSSERVER\nzone "_acme-challenge.${2}"\nupdate add _acme-challenge."${2}" $TTL in TXT "${4}"\nsend" | $NSUPDATE
        ;;
    "clean_challenge")
        echo -e "server $DNSSERVER\nzone "${2}"\nupdate delete _acme-challenge."${2}" $TTL in TXT "${4}"\nsend" | $NSUPDATE
        ;;
    "deploy_cert")
        # optional:
        # /path/to/deploy_cert.sh "$@"
        ;;
    "unchanged_cert")
        # do nothing for now
        ;;
    "startup_hook")
        # do nothing for now
        ;;
    "exit_hook")
        # do nothing for now
        ;;
esac

exit 0
```

### kôté knot..

Ajouter les sous domaines acme_-challenge..

```bash
...
acl:
...
  - id: update_acl
    address: 127.0.0.1
    action: update
    key: mykey
...
template:
...
  - id: le
    storage: /var/lib/knot/le
...
- zone:
...
  - domain: _acme-challenge.architux.com
    template: le
    acl: update_acl

  - domain: _acme-challenge.opendns.io
    template: le
    acl: update_acl

  - domain: _acme-challenge.mugairyu.fr
    template: le
    acl: update_acl

  - domain: _acme-challenge.kartooch.com
    template: le
    acl: update_acl
...
```

Exemple de zone minimaliste

```bash
root@ns7:~# cat /var/lib/knot/le/_acme-challenge.architux.com.zone 
_acme-challenge.architux.com.   86400   SOA     ns7.architux.com. root.architux.com. 2018021754 28800 7200 864000 86400
_acme-challenge.architux.com.   300     NS      ns7.architux.com.
```
puis lancer le test défini plus haut

et mettre le cron de renew

```bash
cat /etc/cron.d/dehydrated 
51 3 * * * root /usr/bin/dehydrated -c --config /etc/dehydrated/config
```

pensez à relancer les services pour prise en compte du nouveau certificat

Utilisez *****deploy_cert** du hook pour cela par exemple
