# Puppet

## Installation

Pré-requis


Sur les agents, bien déclarer le nom pleinement qualifié du master (facter hostname + facter domain) !!!

### Server

vérifier que le pid est supprimé 
```bash
/var/run/puppetlabs/puppetserver/puppetserver.pid
```

#### enregistrer l'agent

https://puppet.com/docs/pe/2017.3/installing/installing_agents.html#concept-710

1. bien configurer l'agent puis le lancer
2. attendre quelques minutes et faire un  `puppet cert list` sur le master
3. le nom du node devrait appara�tre, l'enregistrer avec un `puppet cert sign "nom avec fqdn"

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

### lancer puppet agent en dry run

```bash
puppet agent -t --noop
```

### tester � partir d'un autre environnement

ex test

```bash
puppet agent --noop --environment test -t
```

### modules

#### Installation

Exemple d'installation de module :

```bash
puppet module install puppetlabs-apt --version 4.5.1
```

#### Cr�ation

https://puppet.com/docs/pdk/1.x/pdk.html
https://puppet.com/docs/pdk/1.x/pdk_creating_modules.html
https://puppet.com/docs/puppet/5.5/bgtm.html

```bash
# installation de pdk
apt install  pdk

puppet module generate architux-haproxy
```

### le facteur (facter)

https://stackoverflow.com/questions/45825601/puppet-facter-how-to-set-custom-facts-from-yaml-file

1. pousser votre fact dans /opt/puppetlabs/facter/ 
2. ajouter export FACTERLIB=/opt/puppetlabs/facter/ puis "sourcer-le"
3. ln -s /opt/puppetlabs/facter/ /etc/

Les facts en rb vont dans /opt/puppetlabs/facter/

les fichier yaml iront eux dans /opt/puppetlabs/facter/facts.d/
