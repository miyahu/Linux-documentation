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
