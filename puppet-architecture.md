# Puppet architecture

## Profile, rôle et Hiera ou comment dissocier (à peu près) le code des données

L'idée la suivante, Hiera n'hébergerait que les variables et les appels aux rôles (data). Les appels aux classes (code) serait hérités des profiles eux-même appelés par les rôles. 

Exemple :

### Avant

Tous est dans hiera, l'appel des classes et les variables.

```bash
~# cat server1.yaml
---
class:
  - apache
...
```

```bash
~# cat iswebserver.yaml
---
apache::enable: true
apache:vhosts_list:
	- toto.com
	- titi.com
	- tagada.com
...
```
 et c'est tout

### Après

plus compliqué mais plus souple et clair, on mixe hiera, les profiles et les roles. Hiera n'hébergeant pratiquement plus que les variables et les appels aux rôles. 

On appelle le role Puppet

```bash
~# cat server1.yaml
---
class:
  - role::web
...
```

On ne touche pas aux rôles hiera (rôles correspondant aux facts et nom les rôles *modules*)

```bash
~# cat iswebserver.yaml
---
apache::enable: true
apache:vhosts_list:
	- toto.com
	- titi.com
	- tagada.com
...
```
On créé un rôle **web** appellant le profile **apache**


```bash
~# cat site/role/manifests/web.pp
class role::web inherits base {
	include profile::apache
...
}
```

On créé un profile **apache** incluant le module apache

```bash
~# cat site/profile/manifests/apache.pp
class profile::apache inherits profile {
	include apache
...
}
```

## Cas réel

Ma société s'appelle zonama, elle vend des produits en ligne tel des livres, des films etcetera..

Maintenant imaginons quelle mette en oeuvre les trois types de stacks de serveur suivantes :

1. haproxy, varnish, apache, memcache et php-fpm  
Cette stack s'appelle **zonamaweb**

2. mysql  
Cette stack s'appelle **zonamasql**

3. solr  
Cette stack s'appelle **zonamaslr**

Répartis sur les environnements suivants :

1. production alias **prd**
2. préproduction alias **ppd**
3. recette alias **rct**

Chaque environnement aura des valeurs de configuration différentes même s'ils font appelles aux mêmes composants.  

Le nom complet d'un de mes serveurs web de production sera donc **zonamaprdweb3**, celui d'un serveur mysql de préprod sera **zonamappdsql2** et enfin celui d'un serveur solr de recette sera **zonamaarctslr4** 

#### Voici comment nous  gérerions cette architecture avec Puppet.

Nous aurons trois environnements Puppet :

* production
* préproduction
* recette

Nous aurons trois rôles puppet :

1. zonamaweb
2. zonamasql
3. zonamaslr

et enfin nous définirons les profiles suivants :

1. haproxy1
  appellant les classes :
  1. haproxy
  2. backup haproxy
  3. supervision haproxy
2. varnish1
  appellant les classes :
  1. varnish
  2. backup varnish
  3. supervision varnish
3. apache1
  appellant les classes :
  1. apache
  2. backup apache
  3. supervision apache
4. php-fpm1
  appellant les classes :
  1. php-fpm
  2. backup php-fpm
  3. supervision php-fpm
5. memcached1
  appellant les classes :
  1. memcached
  2. backup memcached
  3. supervision memcached
6. mysql1
  appellant les classes :
  1. mysql
  2. backup mysql
  3. supervision mysql
7. solr1
  appellant les classes :
  1. solr
  2. backup solr
  3. supervision solr
8. base1
  appellant les classes :
  1. base
  2. agent de sauvegarde
  3. agent de supervision

Le rôle zonamaweb appellera les profiles

* base
* haproxy
* varnish
* apache 
* php-fpm
* memcached

Le rôle zonamasql appellera les profiles

* base
* sql

Le rôle zonamaslr appellera les profiles

* base
* solr

### Côté hiera

Nous créerons les externals facts suivants :

* production
* preproduction
* recette
* isweb
* issql
* issolr

La hierarchie Hiera ressemblant à ça (exemple avec l'en de production) :

  - name: "Per-node data (yaml version)"
    path: "nodes/%{::trusted.certname}.yaml"

  - name: "Per codename"
    path: "os/distro/%{facts.os.distro.codename}.yaml"

  - name: "Per os family"
    path: "os/family/%{facts.os.family}.yaml"

  - name: "Per environnement"
    path: "env/production/true.yaml"
    #  héberge les valeurs spécifique à l'environnement
    # quelque soit le service

  - name: "Is web server"
    path: "roles/isweb/true.yaml"

  - name: "Is sql server"
    path: "roles/issql/true.yaml"

  - name: "Is solr server"
    path: "roles/issolr/true.yaml"
