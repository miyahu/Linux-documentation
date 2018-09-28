# Hiera

## configuration hiera (hiera.yaml)

**Tous changement dans ce fichier doit être suivi d'un rechargement Puppet**

#### comment interroger hiera5

```bash 
puppet lookup "variable"
```

Ou **class::var**

```bash 
puppet lookup ntp::service_name
```

#### comment appeller une variable d'un espace de nom différent

exemple, je veux utiliser 

```bash 
knot::service::service_name: 'knot'
```

dans la classe config, normalement je ne peux pas à moins d'ajouter la variable suivante

```bash 
knot::config::service_name: 'knot'
```

mais cette solution à un gout amer.. 

En voici une autre, dans la classe, appelez l'espace de nom complet

```bash 
$service_name   = hiera('knot::service::service_name'),
```

