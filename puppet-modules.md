# Modules

## Hiera dans les modules

1. créer un fichier hiera.yaml pour définir la hierachie
2. créer un dossier date
3. dans ce dossier créer les entrées de hiera
4. modifier le fichier metadata.json  

### hiera, vars et modules

déclarer les clés dans hiera sans espace de nom spécfique :

avant
nom-du-module::config:clé: 'valeur'
après
nom-du-module::clé: 'valeur'

  
déclarer les variables dans init.pp
mettre des inherits dans les autres pp 
