### copier des données - local vers distant
```
ansible -i hosts  all  -m copy -a "src=roles/haproxy/files/haproxy.cfg dest=/etc/haproxy/"
```

### Mode Ad-hoc et sudo avec ansible 2
utiliser become 
```
ansible cache -m shell --become   -u ansible -a "apt-get -y install socat"
```
