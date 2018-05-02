
## Log Varnish

On peut voir la requête de vérification (utilisant une lib go) faite par acmetool lui-même, suivi d'une autre faite par outbound1.letsencrypt.org. 

```bash
16.172.214.19 - - [08/Jul/2017:16:36:57 +0200] "GET http://mail.artux.com/.well-known/acme-challenge/qkXpj4fcunzX2Iajwng1a8ZAi1U084Nv0HJVgE7k HTTP/1.1" 200 87 "-" "Go-http-client/1.1"
66.133.109.36 - - [08/Jul/2017:16:36:58 +0200] "GET http://mail.artux.com/.well-known/acme-challenge/qkXpj4fcunzX2Iajwng1a8ZAi1U084Nv0HJVgE7k HTTP/1.1" 200 87 "-" "Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://
www.letsencrypt.org)"
```

### renouvellement

```bash
/usr/bin/acmetool want mail.architux.com webmail.archi.com opendns.com imap.archi.com
```

### acmetool

acmetool status pour voir les chemins et d'éventuel erreur

### certbot avec dns et wildcard

/usr/local/bin/certbot  --server https://acme-v02.api.letsencrypt.org/directory -d *.mugairyu.fr --manual --preferred-challenges dns certonly

### le challenge dns

https://opportunis.me/letsencrypt-dns-challenge/

https://serverfault.com/questions/750902/how-to-use-lets-encrypt-dns-challenge-validation

en premier lieu, le lancer à la main 

certbot -d www.mugairyu.fr --manual --preferred-challenges dns certonly

* déployer l'enregistrement TXT donné sur le master DNS
* update du serial
* sur le slave, forcer le transfert avec
```bash
knotc  zone-retransfer mugairyu.fr
```

Press Enter to Continue
Waiting for verification...
Cleaning up challenges

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/www.mugairyu.fr/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/www.mugairyu.fr/privkey.pem
   Your cert will expire on 2018-07-19. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot
   again. To non-interactively renew *all* of your certificates, run
   "certbot renew"
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le






recharger et vérifier

dig -t TXT _acme-challenge.www.mugairyu.fr @163.172.214.190


### les wildcards

Il faut utiliser acmev2

### dehydrated

En premier

```bash
/usr/bin/dehydrated --register --accept-terms
```

ensuite

```bash
dehydrated  -c -f  /etc/dehydrated/config
```

#### pour debugguer

ajouter -d lors de l'appel à knsuupdate

