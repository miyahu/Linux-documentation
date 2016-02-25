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
