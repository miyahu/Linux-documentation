* [failed with error code 1 in /root/build/cryptography](#failed /root/build/cryptography)

### ad-hoc MàJ de sécurité
`ansible messerveurs -s  -m apt -a "name=imagemagick,imagemagick-common state=latest"`

### copier des données - local vers distant
```
ansible -i hosts  all  -m copy -a "src=roles/haproxy/files/haproxy.cfg dest=/etc/haproxy/"
```

### Mode Ad-hoc et sudo avec ansible 2
utiliser become 
```
ansible cache -m shell --become   -u ansible -a "apt-get -y install socat"
```

### Mode Ad-hoc et sudo avec ansible 1.*
```
ansible cache -m shell -s   -u ansible -a "apt-get -y install socat"
```

### copie de clés
```
ansible cache -s -m authorized_key -a "user=ansible key='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQuvjauHdo6MnfukMo8AO8uxcdeq9UudOrxXLLhsSu7oL9Hvk5NDSDcQvnhSXFQulqsHgB9PQ345I773cDanpZOkYn7WXa1tXkcchh3u7Dl5hg8KT8fXwkZLOeqIEHdXTm7CjoIY88lPRxo6fseHg7hqM3/ZJV+AfDfzoa2bY0VVOD5x9JWYioL69i6FAI9Pdsu9biHoBNrOMQXujjIrslP/fPygkR5/TOAcIQTnbjwNWb+bv9R2hghitmeUNNyMaehX+FDRboRPIyE+VWwMdCPXyF1MVA7A2CgN3oEoTB1X75PUR7NJses0dyvu8ZaJ7ZYhQLFydOyme9E/ bob@eollect'"
```
## Ansible et fact

http://jpmens.net/2012/07/15/ansible-it-s-a-fact/

Sur la cible, créer l'arbo
 
`/etc/ansible/facts.d` puis poser un script se terminant par `fact` exemple (du site de jpmens)

```
cat toto.fact
        #!/bin/sh
         
        COUNT=`who | wc -l`
        cat <<EOF
        {
           "ansible_facts" : {
              "users_logged_in" : $COUNT
           }
        }
        EOF
```
#### Test 1

Vérifier avec le module setup :

`ansible tagada7 -m setup -a "filter=ansible_local"`


#### Test2

Dans son playbook, il faut un
`gather_facts: yes`

Et dans la tâche
```
- name: pouet
debug: msg={{ansible_local.toto.ansible_facts.users_logged_in}}
```

failed /root/build/cryptography
-------------------------------

`apt-get install libffi-dev` 
