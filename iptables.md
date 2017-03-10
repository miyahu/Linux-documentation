* [tester un jeu de règles sans le charger](#tester un jeu de règles sans le charger)

### tester un jeu de règles sans le charger

`iptables-restore -t < /tmp/rules`

### ordre des règles

le DROP est terminal, il faut donc insérer en amont les règles d'autorisations.



