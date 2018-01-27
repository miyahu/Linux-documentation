# knot resolver (kresd)

## pilotage et troubleshooting

### pas de réponse lors de forward

1. vérifier que le serveur autoritaire répond suffisament rapidement
2. possible problème config systemd pour supervisor, message bad "NODATA proof" dans les log et **2(SERVFAIL)** dans les logs


### debugger lançant en verbose

```bash
kresd -a 163.172.217.110@53 -v -c /etc/knot-resolver/kresd.conf -f 3
```

### un démon pour init 

```bash
start-stop-daemon -b --start --quiet --exec /usr/sbin/kresd -- -a 163.172.217.110@53 -v -c /etc/knot-resolver/kresd.conf -f 3 /
```

### pilotage par socket de contrôle

Trouver le socket de contrôle avec **lsof** puis lancez-le 

```bash
kresc  /run/knot-resolver/control
```

#### obtenir des stats

```bash
kresc> stats.list()
[answer.nxdomain] => 1
[answer.100ms] => 0
[answer.1500ms] => 0
[answer.slow] => 0
[answer.servfail] => 12
[answer.250ms] => 0
[answer.cached] => 13
[answer.nodata] => 10
[query.edns] => 10
[query.dnssec] => 7
[answer.total] => 26
[answer.10ms] => 0
[answer.noerror] => 3
[answer.50ms] => 0
[answer.500ms] => 1
[answer.1000ms] => 0
[answer.1ms] => 13
```
