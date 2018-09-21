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
