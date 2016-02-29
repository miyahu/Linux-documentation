Dump des privilèges
```
su - postgres
pg_dumpall -g > /tmp/globals_only.dump
```
Insertion
```
su - postgres
cat /tmp/globals_only.dump | psql
```

Dump d'une base 
```
su - postgres
pg_dump newpegasus > /tmp/newpegasus.sql
```
Insertion
```
su - postgres
cat /tmp/globals_only.dump | psql
```
