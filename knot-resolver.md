# knot resolver (kresd)

## pilotage et troubleshooting

### pas de réponse lors de forward

vérifier que le serveur autoritaire répond suffisament rapidement

### tester la configuration

```bash
kresd -vc /etc/knot-resolver/kresd.conf
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
