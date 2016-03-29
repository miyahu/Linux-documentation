https://www.howtoforge.com/how-to-benchmark-your-system-cpu-file-io-mysql-with-sysbench#-mysql-benchmark-

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
Résultat :
```
sysbench 0.5:  multi-threaded system evaluation benchmark

Running the test with following options:
Number of threads: 8
Random number generator seed is 0 and will be ignored


Threads started!

OLTP test statistics:
    queries performed:
        read:                            862694
        write:                           0
        other:                           123242
        total:                           985936
    transactions:                        61621  (1026.95 per sec.)
    read/write requests:                 862694 (14377.29 per sec.)
    other operations:                    123242 (2053.90 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          60.0039s
    total number of events:              61621
    total time taken by event execution: 479.8598s
    response time:
         min:                                  1.91ms
         avg:                                  7.79ms
         max:                                106.02ms
         approx.  95 percentile:              11.88ms

Threads fairness:
    events (avg/stddev):           7702.6250/34.84
    execution time (avg/stddev):   59.9825/0.0
```
