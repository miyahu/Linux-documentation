```
apt install sysbench
```
Lancement
```
sysbench --test=/usr/share/doc/sysbench/tests/db/oltp.lua --oltp-table-size=1000000 --mysql-db=test \--mysql-user=debian-sys-maint --mysql-password=ouiPbrvHGAoGK3u0 prepare
```
