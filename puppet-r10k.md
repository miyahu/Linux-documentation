# r10k

https://github.com/puppetlabs/r10k/blob/master/doc/puppetfile.mkd

Dans r10k, le fichier *Puppetfile* est l'équivalant du *requirements.yml* d'Ansible, il spécifie les modules, leurs versions et leurs origines.  

Les modules ne DOIVENT PAS êtres présent sur le dépôt git de *r10k*, ils sont installés en tant que dépendances lors du déploiement de l'envirronement *r10k*, pour bien comprendre cette séparation, considerez *r10k* comme du code et les modules comme de la donnée (data)    

## Installation et configuration

### Configuration de r10k.yaml

```bash
cat /etc/puppetlabs/r10k/r10k.yaml 
# The location to use for storing cached Git repos
:cachedir: '/var/cache/r10k'
#
# # A list of git repositories to create
:sources:
#   # This will clone the git repository and instantiate an environment per
#     # branch in /etc/puppetlabs/code/environments
  :puppet:
    remote: 'git@github.com:ronron22/Puppet-r10k.git'
    basedir: '/etc/puppetlabs/code/environments'
git:
    private_key: '/etc/puppetlabs/r10k/id-rsa.pub'
```
Pensez à générer la clef ssh : **/etc/puppetlabs/r10k/id-rsa.pub** puis copiez-là sur github.

### Les modules

Il  faudra créer un dépôt github pour chaque module, puis les définirs dans le Puppetfile

## Exemples d'utilisation

Installation de la liste des modules

```bash
r10k puppetfile install
```

Vérification de la syntaxe du Puppetfile

```bash
r10k puppetfile check
```

Suppression des modules

```bash
r10k puppetfile purge
```

## Les modules

### Directive

moduledir:
spécifie où seront installés les modules issues du *Puppetfile*

#### Type de modules et sources

* forge
* git 
* svn

si la version n'est pas fixé, la dernière sera téléchargée

### mettre ses propres modules

1. les mettres sur git (en tant que dépôt et non en tant que sous répertoire sinon, cela ne marche pas).

2. Ce placer dans la copie du dépôt git de r10k, ajouter la ligne qui va bien au Puppetfile

```bash
mod 'apache',
  :git => 'https://github.com/ronron22/puppet-module-apache' 
```

3. Ajouter puis commiter sur le dépôt distant, vérifiez que la branche de travail soit bien celle voulue.

puis, sur le serveur **Puppet** lancer

```bash
r10k deploy  environment -p
```

Cette commande descendra le nouveau module

### laisser des modules locaux

Ajouter 

```bash
mod 'local_module', :local => true
```

au Puppetfile

puis créer le répertoire vide *local_module* dans modules, puis y placer ses modules

Adapter le path des modules dans environnement.conf :

```bash
modulepath = modules:site:modules/local_module:$basemodulepath
```

### mise à jour de l'environnement

#### Ne mettre que les modules à jour

```bash
r10k deploy module
```

ou juste deux modules

```bash
r10k deploy module apache mysql
```

### voir les environnements

```bash
r10k deploy display
```

### Pareil mais avec les modules

```bash
r10k deploy display -p
```
