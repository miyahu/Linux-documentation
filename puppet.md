# Puppet

## Installation

PrÃ©-requis


Sur les agents, bien dÃ©clarer le nom pleinement qualifiÃ© du master (facter hostname + facter domain) !!!

### Server

vÃ©rifier que le pid est supprimÃ© 
```bash
/var/run/puppetlabs/puppetserver/puppetserver.pid
```

#### enregistrer l'agent

https://puppet.com/docs/pe/2017.3/installing/installing_agents.html#concept-710

1. bien configurer l'agent puis le lancer
2. attendre quelques minutes et faire un  `puppet cert list` sur le master
3. le nom du node devrait apparaître, l'enregistrer avec un `puppet cert sign "nom avec fqdn"

#### ssl

dÃ©marrer le master

supprimer sur le master le certificat client
```bash
puppet cert clean clientname
```
Sur le client, s'enregistrer le client avec un 

```bash
/opt/puppetlabs/bin/puppet agent --test                                                             
```

Puis signer rapidement la requÃªte de certif
```bash
```

## appliquer un manifest en ligne de commande

exemple pour le manifest site

```bash
puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp
```

## configuration

### prÃ©sentation de l'arborescence

Le manifest

```bash
/etc/puppetlabs/code/environments/production/manifests/site.pp
```

appelle la classe **generals** dÃ©finie dans cette arborescence

```bash
/etc/puppetlabs/code/environments/production/modules/generals/
```

#### manifest



## exploitation

### désactiver un agent sans couper le service

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

### tester à partir d'un autre environnement

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

#### Création

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

## modules

### changement de fichier entrainant un redémarrage de service 

Utilisez "notify  => Service['nom du service']"

```bash
file { '/etc/haproxy/haproxy.cfg':
              ensure  => present,
              content => file("haproxy/${nodename}/etc/haproxy/haproxy.cfg"),
              notify  => Service['haproxy']
            }
service { 'haproxy':
              ensure  => running,
              enable  => true,
              restart => 'haproxy -c -f /etc/haproxy/haproxy.cfg && service haproxy reload',
              require => File['/etc/haproxy/haproxy.cfg'],
            }
```

### héritage de classe

Où l'on utilise le mot clé "inherits" pour faire hériter 3 classes d'un classe de base :

Exemple : https://fr.slideshare.net/PuppetLabs/roles-talk

https://puppet.com/docs/puppet/4.10/lang_classes.html#inheritance

```bash
class apache {
  service {'apache':
    require => Package['httpd'],
  }
}

class apache::ssl inherits apache {
  Service['apache'] {
    require +> [ File['apache.pem'], File['httpd.conf'] ],
  }
}
```

Le +> se substitue au => pour signifier que la nouvelle valeur s'ajoute à l'ancienne :

anciennes valeurs : Package['httpd']
Nouvelles valeurs après ajouts : Package['httpd'] File['apache.pem'], File['httpd.conf']

### tags

Le tag des fonctions.
 
Le tag sert à appeller uniquement la classe correspondant au nom du tag, l'idée étant pour une opération manuel, d'éviter d'appeller l'ensemble des classes.

Comme Ansible puppet support les tags, il faut le spécifier dans la classe (au début sera parfait), exemple

```bash
class apache::specifique inherits apache {
  tag 'apache-specifique'
  ..
}
```
Puis le tag est appelé ainsi

```bash
~# puppet agent -t --tag apache-specifique
```

Il existe aussi le tag des metaparamètres

