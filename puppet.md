# Puppet

Il faut voir **Puppet** comme un outils de mise en conformit� des configurations et des contenus.

## Imp�ratif vs d�claratif

Si le code demande (les proc�dures) � l'interpr�teur (puppet) quoi, comment et quand le faire , il s'agit d'un code imp�ratif.
Si le code se contente de demander � l'interpr�teur ce qu'il veut obtenir comme r�sultat, il s'agit d'un code d�claratif.

## Variables

Elles commencent par une minuscule ou un soulignement (underscore) et doit contenir les lettres en minuscules, des nombres et des soulignements.

### Voir le type de variable

```bash
include stdlib
$nametype = type_of( $my_name ) 
$numtype  = type_of( $num_token ) 
```

### Variable avec here document

```bash
$message_text = @("END")
Dear ${user},
	Your password is ${password}.
END
```

### Les hashs

Il est possible d'ajouter ou retirer des entr�es d'un hash, exemple

```bash
$name			= [ 'adolph hitler', 'george bush', 'mere theresa ]
$name_with_fix	= $name - 'mere theresa'
```

### Op�rateurs de comparaison

les habituelles, plus :

* pour les amateurs de python 

```bash
 'Pinochet' in 'Bad person : Hitler, Bush, Pinochet'
 'Bamby' !in 'Bad person : Hitler, Bush, Pinochet'
```

Exemple

```bash
$bad_person = ['Hitler', 'George Bush', 'Bambie']

if ('Bambie' in $bad_person) {
	notify { 'is_bambie':
		message => "Oui !!!"
	}
}
else {
	notify { 'is_bambie':
		message => "Non !!!"
	}
}
```

### Mots r�serv�s

and, att, node, true, import default etc..

### Les op�rateurs conditionnels

* if/elsif/else
* unless/else 
* case
* selecteur

L'op�rateur permet de faire des trucs sympa du genre

case $osfamily {
	'redhat'				{ include yum }
	'debian'				{ include apt }
	'debian-ubuntu' { include apt }
	'windows'				{ include garbage }
}

## Les facts

### Lister les facts avec puppet 

```bash
puppet facts --render-as yaml
```

### Utilisation des facts dans les ressources

```bash
notify { 'greeting':
  message => "Am i virtual ? ${is_virtual}"
}
```

rendu

```bash
Notice: Am i virtual ? false
```

### La synchronisation des plugins et facts avec pluginsync

https://puppet.com/blog/introduction-pluginsync

Lors de l'execution des jobs, l'agent puppet r�cup�re les plugins et facts du puppet master

## Les fonctions

En Puppet 5.5

https://puppet.com/docs/puppet/5.5/function.html

## Ordre d'application 

before => Type['deploywebroot']
require => Type['/etc/apache2/apache.conf']

## Installation

Pré-requis

Sur les agents, bien déclarer le nom pleinement qualifié du master (facter hostname + facter domain) !!!

### Server

vérifier que le pid est supprimé 
```bash
/var/run/puppetlabs/puppetserver/puppetserver.pid
```

#### Enregistrer l'agent

https://puppet.com/docs/pe/2017.3/installing/installing_agents.html#concept-710

1. bien configurer l'agent puis le lancer
2. attendre quelques minutes et faire un  `puppet cert list` sur le master
3. le nom du node devrait appara�tre, l'enregistrer avec un `puppet cert sign "nom avec fqdn"

#### Ssl

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

## Appliquer un manifest en ligne de commande

exemple pour le manifest site

```bash
puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp
```

## V�rifier la syntaxe des pp

La validation est un peu con, m�fiez-vous quand m�me..

```bash
puppet parser validate mon.pp 
```

## Configuration

### Pr�sentation de l'arborescence

Le manifest

```bash
/etc/puppetlabs/code/environments/production/manifests/site.pp
```

appelle la classe **generals** définie dans cette arborescence

```bash
/etc/puppetlabs/code/environments/production/modules/generals/
```

#### Manifest

##### d�pendances entre modules

Je veux que le module php execute la classe accounts avant de lancer le service

J'ajoute

```bash
 require => Class["accounts"] 
```

dans service.pp du module php

## Exploitation

### D�sactiver un agent sans couper le service

```bash
 puppet agent --disable
```

### Retirer un agent puppet

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
pdk new module
```

ou 

```bash
puppet module generate architux-haproxy
```

### Le facteur (facter)

https://stackoverflow.com/questions/45825601/puppet-facter-how-to-set-custom-facts-from-yaml-file

1. pousser votre fact dans /opt/puppetlabs/facter/ 
2. ajouter export FACTERLIB=/opt/puppetlabs/facter/ puis "sourcer-le"
3. ln -s /opt/puppetlabs/facter/ /etc/

Les facts en rb vont dans /opt/puppetlabs/facter/

les fichier yaml iront eux dans /opt/puppetlabs/facter/facts.d/

##�Modules

### Changement de fichier entrainant un red�marrage de service 

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

### H�ritage de classe

O� l'on utilise le mot cl� "inherits" pour faire h�riter 3 classes d'un classe de base :

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

Le +> se substitue au => pour signifier que la nouvelle valeur s'ajoute � l'ancienne :

anciennes valeurs : Package['httpd']
Nouvelles valeurs apr�s ajouts : Package['httpd'] File['apache.pem'], File['httpd.conf']

### Tags

Le tag des fonctions.
 
Le tag sert � appeller uniquement la classe correspondant au nom du tag, l'id�e �tant pour une op�ration manuel, d'�viter d'appeller l'ensemble des classes.

Comme Ansible puppet support les tags, il faut le sp�cifier dans la classe (au d�but sera parfait), exemple

```bash
class apache::specifique inherits apache {
  tag 'apache-specifique'
  ..
}
```
Puis le tag est appel� ainsi

```bash
~# puppet agent -t --tag apache-specifique
```

Il existe aussi le tag des metaparam�tres

### Afficher la config du client puppet

```bash
puppet config print
```

## Sauvegarde des �l�ments modifi�s

Sur le client sur lesquels sont appliqu�s les .pp, les �l�ments modifi�s sont automatiquement sauvegard�s ici :

puppet config print | grep clientbucketdir
clientbucketdir = /var/cache/puppet/clientbucket

### Lister les �l�ments sauvegard�s

```bash
puppet filebucket --local list
557435b41c7835c8c50390341c398e4e 2018-09-13 16:02:24 /tmp/gruik
```

### Afficher un �l�ment sauvegard�

```bash
puppet filebucket --local get 557435b41c7835c8c50390341c398e4e
gruik!
```
/var/cache/puppet/clientbucket/
