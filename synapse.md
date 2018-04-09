https://github.com/matrix-org/synapse#introduction

###  changer le mot de passe

```bash
cd /usr/local/synapse/

./bin/hash_password

sqlite3 /usr/local/synapse/db/homeserver.db


sqlite> select * from users ;
@onio:flood.open.io|$2b$12$P9g2qbIe1MsDn6//QFg2webHzkE7xEN|1515766435|1||0|
@jona:flood.open.io|$2b$12$P4cBXZxd5aY5IWgVmeCgLuNjd9GPD.|1515772331|1||0|
```

 puis update

```bash
UPDATE users SET password_hash='$2a$12$YmuJhced5UKWnIY0zReuFXG9alDxhcZz1OWd60VSuuvx.feshYu'WHERE name='@onio:flood.opendns.io';
```
