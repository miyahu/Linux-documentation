
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
