## Dump et restore
###Dump des privilèges
```
su - postgres
pg_dumpall -g > /tmp/globals_only.dump
```
###Insertion
```
su - postgres
cat /tmp/globals_only.dump | psql
```

###Dump d'une base 
```
su - postgres
pg_dump mabase > /tmp/mabase.sql
```
###Réinsertion 
```
su - postgres
psql mabase < /tmp/mabase.sql
```
## Création des comptes
### création de l'utilisateur ainsi que de son mot de passe
```
CREATE USER tagada WITH PASSWORD 'pouet';
```
### création de la base
```
CREATE DATABASE rantanplan OWNER tagada;
```
# commandes usuelles
### lister les bases
```
\l
```
### ce connecter à une base
```
\c mabase
```
### lister les tables
```
\dt
```
# troubleshooting

## ERROR:  relation "" does not exist postgres
```
GRANT usage on schema public to latribune_php7;
```
## Insufficient privilege: 7 ERROR:  permission denied for relation permalinks
```
GRANT ALL  ON database latribune_php7 TO latribune_php7;
```
```
SELECT * FROM pg_roles ;
```
Vérifier avec un "\connect" et un "\dt" que le propriétaire est bien celui qui doit être.
```
                     Liste des relations
 Schéma |             Nom             | Type  | Propriétaire
--------+-----------------------------+-------+---------------
 public | allowed_block          | table | tagada
 public | applications                | table | tagada
```
puis Changement du owner des tables 

Bien vérifier que l'on attaque les bonnes tables avec un 
```
while read line ; do psql latribune_php7 -c "select * from  $line limit 1;" ; done <  /tmp/out2
```
```
while read line ; do psql tagada -c "alter table $line owner to tralala;" ; done <  /tmp/out2
```
