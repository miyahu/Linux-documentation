# environement de devellopement pour Ansible avec Docker
* [docker](#docker)
* [installation de docker](#installation-de-docker)
* [docker-compose](#docker-compose)
* [installation de docker compose](#installation-de-docker-compose)
* [préparation du dockerfile](#préparation-du-dockerfile)
* [configuration de docker-compose](#configuration-de-docker-compose)
* [vérifier le démarrage des instances](#vérifier-le-démarrage-des-instances)
* [accéder à ses instances docker](#accéder-à-ses-instances-docker)
* [commiter les modifications effectuées dans l'instance](#commiter-les-modifications-effectuées-dans-l'instance)
* [débugger docker-compose](#débugger-docker-compose)
* [test unitaire avec kitchen](#test-unitaire-avec-kitchen)
* [supprimer un container](#supprimer-un-container)
* [supprimer une image](#supprimer-une-image)
* [supprimer une interface] (#supprimer-une-interface)
* [debugging docker] (#debugging-docker)
* [build avec un docker spécifique] (#build-avec-un-docker-spécifique)
* [supprimer un paquet d'image] (#supprimer-un-paquet-d'image)

## docker

### installation de docker

On install la dernière version de docker

```
wget -qO- https://get.docker.com/ | sh

```

On ajoute l'utilisateur au groupe docker pour ne pas devoir faire du sudo continuellement.

```
usermod -G docker $(whoami)
```

Et enfin se relogguer

## docker-compose

### installation de docker-compose

se placer dans le répertoire development/ puis lancer docker-compose
On fixe la version de compose
```
curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
```
### Préparation du dockerfile

```
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
```

### configuration de docker compose
```
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
```

### manipulation de docker-compose

#### démarrage des instances

```
docker-compose up -d 
```

#### arrêt des instances

```
docker-compose down
```

### vérifier le démarrage des instances

```
docker ps
```

### accéder à ses instances docker

```
docker exec -it lamphc bash
```
### commiter les modifications effectuées dans l'instance

Je veux rendre pérenne une modification effectuée dans l'instance

Je commit les modifs avec :

```
sudo docker commit 'ID CONTAINER' 'nom du commit'
```

je vérifie la présence de la nouvelle image avec 

```
sudo docker images
```

Je le démarre avec un 

```
sudo docker run 'nom du commit'
```

### débugger docker-compose

le lancer en avant-plan 

```
docker-compose up
```

puis observer la suite.

Si une image docker a une anomalie, la supprimer 

```
sudo docker ps -a |awk '/NOM DE L'IMAGE/ {print$1}'
```
puis rebuilder la stack avec un 

```
docker-compose up -d
```

### test unitaire avec kitchen

Actuellement les tests sont effectués sur le gitlab, lors d'un commit (trigger) 

Les tests sont utilisés sur les rôles et non sur les archis (actuellement s'entends).

Ils est prévus à terme de lancer les tests sur sa machine local ...

### supprimer un container

Tout d'abord, le stopper

`docker stop "mon conteneur"`

trouver son id

`docker ps -a | grep  "mon conteneur" | awk '{print$1}'`

et enfin, le supprimer

`docker rm 'id'`

### supprimer une image

```
sudo docker rmi -f "IMAGE ID"
```

### supprimer une interface

lister les interfaces avec 

`docker network ls`

Puis supprimer celle désiré avec *rm*, exemple

`docker network rm e31b7cdb5395` 

### debugging docker

```
docker logs "mon instance"
```

```
docker inespect "mon instance"
```

### build avec un docker spécifique

```
docker build -f ./Dockerfile-grafana .
```

### supprimer un paquet d'image

```
for i in $(docker image ls | awk '{print$1}' | grep development_)  ; do docker image rm  $i ; done
```

### démarrer une première instance en montant des volumes


```bash
docker run -d -v/var/www/kanboard-docker/data:/var/www/app/data -v /var/www/kanboard-docker/plugins:/var/www/app/plugins --name kanboardamoaeuh -p 8083:80 -t kanboardamo
```
ou

```bash
docker run -d -v/var/www/kanboard-docker/data:/var/www/app/data -v /var/www/kanboard-docker/plugins:/var/www/app/plugins -v /var/www/kanboard-docker/data/config/config.php:/var/www/app/data/config.php --name kanboardamoaeuh -p 8083:80 -t kanboardamo

 docker run -d  --publish 8080:8080 dutchcoders/transfer.sh:latest --provider local --basedir /tmp/

```

### démarrer automatiquement un container au boot

```bash
docker update --restart=always "id conteneur"
```

#### voir si le démmarrage auto est activé

```bash
 grep --color=auto start /var/lib/docker/containers/b40c54465fb1cca94f93abc42f25c7a6653a2c4dd920d7a0f16fa14066a3e057/hostconfig.json 
{"Binds":["/var/www/kanboard-docker/data:/var/www/app/data","/var/www/kanboard-docker/plugins:/var/www/app/plugins","/var/www/kanboard-docker/data/config/config.php:/var/www/app/config.php"],"ContainerIDFile":"","LogConfig":{"Type":"json-file","Config":{}},"NetworkMode":"default","PortBindings":{"80/tcp":[{"HostIp":"","HostPort":"8083"}]},"RestartPolicy":{"Name":"always","MaximumRetryCount":0},"AutoRemove":false,"VolumeDriver":"","VolumesFrom":null,"CapAdd":null,"CapDrop":null,"Dns":[],"DnsOptions":[],"DnsSearch":[],"ExtraHosts":null,"GroupAdd":null,"IpcMode":"shareable","Cgroup":"","Links":null,"OomScoreAdj":0,"PidMode":"","Privileged":false,"PublishAllPorts":false,"ReadonlyRootfs":false,"SecurityOpt":null,"UTSMode":"","UsernsMode":"","ShmSize":67108864,"Runtime":"runc","ConsoleSize":[0,0],"Isolation":"","CpuShares":0,"Memory":0,"NanoCpus":0,"CgroupParent":"","BlkioWeight":0,"BlkioWeightDevice":[],"BlkioDeviceReadBps":null,"BlkioDeviceWriteBps":null,"BlkioDeviceReadIOps":null,"BlkioDeviceWriteIOps":null,"CpuPeriod":0,"CpuQuota":0,"CpuRealtimePeriod":0,"CpuRealtimeRuntime":0,"CpusetCpus":"","CpusetMems":"","Devices":[],"DeviceCgroupRules":null,"DiskQuota":0,"KernelMemory":0,"MemoryReservation":0,"MemorySwap":0,"MemorySwappiness":null,"OomKillDisable":false,"PidsLimit":0,"Ulimits":null,"CpuCount":0,"CpuPercent":0,"IOMaximumIOps":0,"IOMaximumBandwidth":0}
```
