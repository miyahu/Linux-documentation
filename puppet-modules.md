# Modules

## Hiera dans les modules

1. créer un fichier hiera.yaml pour définir la hierachie
2. créer un dossier data
3. dans ce dossier créer les entrées de hiera
4. modifier le fichier metadata.json  

### hiera, les variables  et modules

#### retirer l'espace de nom du module 

avant

```yaml
nom-du-module::config:clé: 'valeur'
```

après

```yaml
nom-du-module::clé: 'valeur'
```
  
Pour déclarer des clés dans hiera sans espace de nom spécfique, il faut définir les variables dans la class principal présente dans l'init.pp du module

N'oubliez pas de mettre des inherits dans les autres classes.. 

### comment appeler les classes d'un module

avec *include*

include mon_module

avec *class*; cette méthode offrant la possibilitée de surcharger les paramètres

```puppet
class { 'mon_module':
  configuration_directory => '/etc/mon_module',
}
```

ou de changer l'ordre d'execution des classes, par exemple

```puppet
  anchor { 'postfix::begin': } ->
  class { '::postfix::install': } ->
  class { '::postfix::config': } ~>
  class { '::postfix::service': } ->
  anchor { 'postfix::end': }
```
