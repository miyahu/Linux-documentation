* [environement de devellopement pour Ansible avec Docker](#environement-de-devellopement-pour-Ansible-avec-Docker)
* [docker](#docker)
*   [Préparation du dockerfile](#Préparation-du-dockerfile)
* [docker-compose](#docker-compose)
*  [Configuration de docker-compose](#Configuration-de-docker-compose)

## environement de devellopement pour Ansible avec Docker


### docker

1. On install la dernière version de docker

`̀ ̀ 
wget -qO- https://get.docker.com/ | sh
`̀ ̀ 

2. On ajoute l'utilisateur au groupe docker pour ne pas devoir faire du sudo continuellement.

`̀ ̀ 
usermod -G docker $(whoami)
`̀ ̀ 

Et enfin se relogguer

### docker-compose

se placer dans le répertoire development/ puis lancer docker-compose
On fixe la version de compose
`̀ ̀ 
curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
`̀ ̀ 
### Préparation du dockerfile
`̀ ̀ 
FROM debian:jessie

ENV ANSIBLE_VERSION 2.1
ENV TERM=xterm

RUN sed -i "s/jessie main/jessie main contrib non-free/" /etc/apt/sources.list

RUN apt-get update --fix-missing && \
    apt-get install -y python-dev python-pip libffi-dev libssl-dev sudo openssh-server openssh-client curl vim module-init-tools net-tools && \
    pip install --upgrade setuptools cryptography && \
    pip install ansible==$ANSIBLE_VERSION

RUN mkdir /var/run/sshd  && \
    sed -ri 's/^session\s+required\s+pam_loginuid.so$/session optional pam_loginuid.so/' /etc/pam.d/sshd  && \
    ssh-keygen -A  && \
    useradd -ms /bin/bash ansible && \
    echo 'ansible:ansible' | chpasswd  && \
    echo "ansible ALL=(ALL:ALL) NOPASSWD:ALL">>/etc/sudoers && \
    mkdir -p /var/log/ansible/ /var/cache/ansible && \
    touch /var/log/ansible/ansible.log && \
    chown ansible: /var/cache/ansible /var/log/ansible/ansible.log

RUN apt-get install -y lsb-release

USER ansible
RUN ssh-keygen -q -t rsa -N '' -f /home/ansible/.ssh/id_rsa && \
    echo "Host *\n\tStrictHostKeyChecking no" > /home/ansible/.ssh/config && \
    cat /home/ansible/.ssh/id_rsa.pub > /home/ansible/.ssh/authorized_keys
ENV HOME /home/ansible

WORKDIR /usr/local/ansible/orchestrator/
`̀ ̀ 
### Configuration de docker-compose
`̀ ̀ 
---
version: '2'
networks:
  lamp:
    driver: bridge
    ipam:
      driver: default
#      config:
#      - subnet: 10.65.0.0/16
#        gateway: 10.65.0.254

services:
  lamphc:
    build: .
    container_name: lamphc
    hostname: lamphc
    networks:
      lamp:
    privileged: true
    stdin_open: true
    volumes:
      - ../:/usr/local/ansible/orchestrator/
    cap_add:
      - ALL

  lamp1:
    build: .
    container_name: lamp1
    hostname: lamp1
    networks:
      lamp:
    user: root
    working_dir: /root
    command: "/usr/sbin/sshd -D"
    privileged: true
    cap_add:
      - ALL
`̀ ̀ 

### manipulation de docker-compose

#### Démarrage des instances

`̀ ̀ 
docker-compose up -d 
`̀ ̀ 

#### Arrêt des instances

`̀ ̀ 
docker-compose down
`̀ ̀ 

## Test unitaire avec Kitchen:

Actuellement les tests sont effectués sur le gitlab, lors d'un commit (trigger) 

Les tests sont utilisés sur les rôles et non sur les archis (actuellement s'entends).

Ils est prévus à terme de lancer les tests sur sa machine local ...

