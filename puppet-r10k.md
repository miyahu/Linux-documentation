# r10k

https://github.com/puppetlabs/r10k/blob/master/doc/puppetfile.mkd

Dans r10k, le fichier *Puppetfile* est l'équivalant du *requirements.yml* d'Ansible, il spécifie les modules, leurs versions et leurs origines.  

Les modules ne DOIVENT PAS êtres présent sur le dépôt git de *r10k*, ils sont installés en tant que dépendances lors du déploiement de l'envirronement *r10k*, pour bien comprendre cette séparation, considerez *r10k* comme du code et les modules comme de la donnée (data)    

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

## directive

moduledir:
spécifie où seront installés les modules issues du *Puppetfile*

#### Type de modules et sources

* forge
* git 
* svn

si la version n'est pas fixé, la dernière sera téléchargée

### mettre ses propres modules

1. les mettres sur git (en tant que dépôt et non en tant que sous répertoire sinon, cela ne marche pas).

Ce placer dans la copie du dépôt git de r10k, ajouter la ligne qui va bien au Puppetfile

```bash
mod 'apache',
  :git => 'https://github.com/ronron22/puppet-module-apache' 
```

Ajouter puis commiter sur le dépôt distant, vérifiez que la branche de travail soit bien celle voulue.

puis, sur le serveur **Puppet** lancer

```bash
r10k deploy  environment -p
```

Cette commande descendra le nouveau module
