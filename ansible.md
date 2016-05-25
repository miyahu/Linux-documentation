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
