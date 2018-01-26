https://github.com/matrix-org/synapse#introduction

###  changer le mot de passe

```bash
cd /usr/local/synapse/

sqlite3 /usr/local/synapse/db/homeserver.db

source bin/activate

sqlite> select * from users ;
@onio:flood.open.io|$2b$12$P9g2qbIe1MsDn6//QFg2webHzkE7xEN|1515766435|1||0|
@jona:flood.open.io|$2b$12$P4cBXZxd5aY5IWgVmeCgLuNjd9GPD.|1515772331|1||0|
```
