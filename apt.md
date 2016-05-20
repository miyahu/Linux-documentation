### Forcer la version backport d'un paquet
Le -t correspond à target release
```
apt-get install haproxy -t jessie-backports
```

### Forcer la version d'un paquet
```
apt-get install  php5-mysql=5.5.30-1~dotdeb+7.1
```
### geler la version d'un paquet
Avec elasticsearch
`echo "elasticsearch hold" | dpkg --set-selections`

On vérifie avec un

```
dpkg --get-selections elasticsearch
elasticsearch                                   hold
```
### voir la liste des clés chargées
`apt-key list`



