## dkim
### interrogation DKIM

Il faut directement interroger le domaine

Dans mon cas, le selector est le domaine "mail"

```bash
host -t TXT mail._domainkey.architux.com ns7.architux.com
Using domain server:
Name: ns7.architux.com
Address: 163.172.214.190#53
Aliases: 

mail._domainkey.architux.com descriptive text "v=DKIM1\; k=rsa\; " "p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDY4jFa3qPsw52rsYBKYv7dd/K+bEVAHxQWbZ2fIM9kNi7jxA4B3aMxu5UQjhOVZOnUJWc7OvldImDclr0QcYnNdLlGUV2osCwY+vgbzaNqj/aghO4EbpAxp3GX1brHgyMenO3gZ4QtsxfcfPPL+r5z1hDZr/UcOJgxfoqIewNRswIDAQAB"
```
Exemple d'entête dkim dans le mail reçu

```bash
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=architux.com; s=mail; t=1499699653; bh=uz2qvOizggI0E7Z53qwQPqPUAMKYzTB1KW5TNQtCfiI=; h=Date:From:Subject:To:From; b=XtW44+CDy9hzX9Uo5P2OMJ3sUs9gpQuVk0SoBehXiqtrW+k8BN7u4H55+zQEBVXco
     Y+u7Se4iJCqFirIrNMWCsykjJvdcYakDV8D9sHmCeCSBOSFcgmxx0p6pIWOZb/ADz5
     mFS+m3eD8X9/Cin8BEncUM1aEZWSElHUDIDurmMs=
```
* v1 : version
* a : algo de chiffrement
* d : domaine émetteur
* s : le selecteur (mail) 
* h: les entêtes signés
* t : unix time
* bh : hash du corp de message 
* b : signature dkim, signé avec la clé public du serveur emetteur (DNS)


## SPF
### interrogation spf

Il faut directement interroger le domaine
```bash
host -t TXT  ns7.architux.com                                                                                                                           
ns7.architux.com has no TXT record
antonio@lapton:~$ host -t TXT  architux.com ns7.architux.com                                                                                                              
Using domain server:
Name: ns7.architux.com
Address: 163.172.214.190#53
Aliases: 

architux.com descriptive text "v=spf1 ip4:163.172.214.190 ip4:195.154.236.164 -all"
```
