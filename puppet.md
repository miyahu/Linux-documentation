# Puppet

## Installation

Pré-requis


Sur les agents, bien déclarer le nom pleinement qualifié du master (facter hostname + facter domain) !!!

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

## appliquer un manifest en ligne de commande

exemple pour le manifest site

```bash
puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp
```

## configuration

### présentation de l'arborescence

Le manifest

```bash
/etc/puppetlabs/code/environments/production/manifests/site.pp
```

appelle la classe **generals** définie dans cette arborescence

```bash
/etc/puppetlabs/code/environments/production/modules/generals/
```

#### manifest



## exploitation

### d�sactiver un agent sans couper le service

```bash
 puppet agent --disable
```

### retirer un agent puppet

```bash
puppet cert list --all | grep "node name"
```

puis le retirer

```bash
puppet cert clean "node name"
```




