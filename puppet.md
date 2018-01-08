# Puppet

## Installation

### Server

vérifier que le pid est supprimé 
```bash
/var/run/puppetlabs/puppetserver/puppetserver.pid
```

#### ssl

démarrer le master

supprimer sur le master le certificat client
```bash
puppet cert clean clientname
```
Sur le client, s'enregistrer le client avec un 

```bash
/opt/puppetlabs/bin/puppet agent --test                                                             
```

Puis signer rapidement la requête de certif
```bash
```


