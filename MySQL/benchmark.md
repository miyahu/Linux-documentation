```
apt install sysbench
```
Préparation de la base
```
sysbench --test=/usr/share/doc/sysbench/tests/db/oltp.lua --oltp-table-size=1000000\
--mysql-db=test --mysql-user=debian-sys-maint --mysql-password=ouiPbrvHGAoGK3u0 prepare
```
Lancement du test
```
sysbench --test=/usr/share/doc/sysbench/tests/db/oltp.lua --oltp-table-size=1000000 \ 
--mysql-db=test --mysql-user=debian-sys-maint --mysql-password=ouiPbrvHGAoGK3u0 \
--max-time=60 --oltp-read-only=on --max-requests=0 --num-threads=8 run
```
