== Présentation ==

RabbitMQ est un programme permettant de gérer des files de messages afin de permettre à différents clients (applications) de communiquer entre eux/elles. Pour que chaque client (application) puisse communiquer avec RabbitMQ, celui-ci s’appuie sur le protocole AMQP.

Source http://www.disko.fr/reflexions/technique/accelerez-vos-applications-avec-rabbitmq/

== Installation et configuration ==

=== Installation ===

Installation de la version standard
 apt-get -y install rabbitmq-server

Activation du plugin de management
 rabbitmq-plugins enable rabbitmq_management

Récupération du script
 root@bz3:~#  wget   http://localhost:15672/cli/rabbitmqadmin

Copie du script dans ''/usr/local/''
<pre>
root@bz3:~# cp -v   rabbitmqadmin /usr/bin/
`rabbitmqadmin' -> `/usr/bin/rabbitmqadmin
</pre>

Ajout droits d'éxecution
 chmod a+x /usr/bin/rabbitmqadmin 

Activation de la complétion
 root@bz3:~# rabbitmqadmin --bash-completion > /etc/bash_completion.d/rabbitmqadmin

=== Configuration ===

Ajout de l'utilisateur antonio avec le mot de passe antonio
 rabbitmqctl add_user antonio antonio

Passage d'antonio en administrateur 
 rabbitmqctl set_user_tags antonio administrator

Modification des droits
 rabbitmqctl set_permissions antonio .* .* .*

==== Explications ==== 

le ''.*'' correspond aux
* vhost
* queue
* exchange 

==== Interface web d'admin ====

Elle est accessible à http://localhost:15672/ avec le compte précédemment créé.

=== Administration ===

Obtenir de l'aide
 rabbitmqadmin help subcommands 
 rabbitmqadmin help config

Lister les vhosts
<pre>
rabbitmqadmin -H localhost -u antonio -p antonio list vhosts
+------------+----------+----------+---------+
|    name    | recv_oct | send_oct | tracing |
+------------+----------+----------+---------+
| /          | 616      | 1020     | False   |
| pouetpouet |          |          | False   |
+------------+----------+----------+---------+
</pre>


Exemples tirés du ''man''

<pre>
       rabbitmqctl stop
           This command instructs the RabbitMQ node to terminate.

       rabbitmqctl stop_app
           This command instructs the RabbitMQ node to stop the RabbitMQ application.

       rabbitmqctl start_app
           This command instructs the RabbitMQ node to start the RabbitMQ application.

       rabbitmqctl wait /var/run/rabbitmq/pid
           This command will return when the RabbitMQ node has started up.

       rabbitmqctl reset
           This command resets the RabbitMQ node.

       rabbitmqctl force_reset
           This command resets the RabbitMQ node.

       rabbitmqctl rotate_logs .1
           This command instructs the RabbitMQ node to append the contents of the log files to files with names consisting of the original logs' names and ".1" suffix, e.g.
           rabbit@mymachine.log.1 and rabbit@mymachine-sasl.log.1. Finally, logging resumes to fresh files at the old locations.

       rabbitmqctl join_cluster hare@elena --ram
           This command instructs the RabbitMQ node to join the cluster that hare@elena is part of, as a ram node.

       rabbitmqctl cluster_status
           This command displays the nodes in the cluster.

       rabbitmqctl change_cluster_node_type disc
           This command will turn a RAM node into a disc node.

       rabbitmqctl -n hare@mcnulty forget_cluster_node rabbit@stringer
           This command will remove the node rabbit@stringer from the node hare@mcnulty.

       rabbitmqctl set_cluster_name london
           This sets the cluster name to "london".

       rabbitmqctl add_user tonyg changeit
           This command instructs the RabbitMQ broker to create a (non-administrative) user named tonyg with (initial) password changeit.

       rabbitmqctl delete_user tonyg
           This command instructs the RabbitMQ broker to delete the user named tonyg.
rabbitmqctl change_password tonyg newpass
           This command instructs the RabbitMQ broker to change the password for the user named tonyg to newpass.

       rabbitmqctl clear_password tonyg
           This command instructs the RabbitMQ broker to clear the password for the user named tonyg. This user now cannot log in with a password (but may be able to through e.g. SASL
           EXTERNAL if configured).

       rabbitmqctl set_user_tags tonyg administrator
           This command instructs the RabbitMQ broker to ensure the user named tonyg is an administrator. This has no effect when the user logs in via AMQP, but can be used to permit
           the user to manage users, virtual hosts and permissions when the user logs in via some other means (for example with the management plugin).

       rabbitmqctl set_user_tags tonyg
           This command instructs the RabbitMQ broker to remove any tags from the user named tonyg.

       rabbitmqctl list_users
           This command instructs the RabbitMQ broker to list all users.

       rabbitmqctl add_vhost test
           This command instructs the RabbitMQ broker to create a new virtual host called test.

       rabbitmqctl delete_vhost test
           This command instructs the RabbitMQ broker to delete the virtual host called test.

       rabbitmqctl list_vhosts name tracing
           This command instructs the RabbitMQ broker to list all virtual hosts.

       rabbitmqctl set_permissions -p /myvhost tonyg "^tonyg-.*" ".*" ".*"
           This command instructs the RabbitMQ broker to grant the user named tonyg access to the virtual host called /myvhost, with configure permissions on all resources whose names
           starts with "tonyg-", and write and read permissions on all resources.

       rabbitmqctl clear_permissions -p /myvhost tonyg
           This command instructs the RabbitMQ broker to deny the user named tonyg access to the virtual host called /myvhost.

       rabbitmqctl list_permissions -p /myvhost
           This command instructs the RabbitMQ broker to list all the users which have been granted access to the virtual host called /myvhost, and the permissions they have for
           operations on resources in that virtual host. Note that an empty string means no permissions granted.

       rabbitmqctl list_user_permissions tonyg
           This command instructs the RabbitMQ broker to list all the virtual hosts to which the user named tonyg has been granted access, and the permissions the user has for
           operations on resources in these virtual hosts.

       rabbitmqctl set_parameter federation local_username '"guest"'
           This command sets the parameter local_username for the federation component in the default virtual host to the JSON term "guest".

       rabbitmqctl clear_parameter federation local_username
           This command clears the parameter local_username for the federation component in the default virtual host.
       rabbitmqctl list_parameters
           This command lists all parameters in the default virtual host.

       rabbitmqctl set_policy federate-me "^amq." '{"federation-upstream-set":"all"}'
           This command sets the policy federate-me in the default virtual host so that built-in exchanges are federated.

       rabbitmqctl clear_policy federate-me
           This command clears the federate-me policy in the default virtual host.

       rabbitmqctl list_policies
           This command lists all policies in the default virtual host.

       rabbitmqctl list_queues -p /myvhost messages consumers
           This command displays the depth and number of consumers for each queue of the virtual host named /myvhost.

       rabbitmqctl list_exchanges -p /myvhost name type
           This command displays the name and type for each exchange of the virtual host named /myvhost.

       rabbitmqctl list_bindings -p /myvhost exchange_name queue_name
           This command displays the exchange name and queue name of the bindings in the virtual host named /myvhost.

       rabbitmqctl list_connections send_pend port
           This command displays the send queue size and server port for each connection.

       rabbitmqctl list_channels connection messages_unacknowledged
           This command displays the connection process and count of unacknowledged messages for each channel.

       rabbitmqctl status
           This command displays information about the RabbitMQ broker.

       rabbitmqctl report > server_report.txt
           This command creates a server report which may be attached to a support request email.

       rabbitmqctl eval 'node().'
           This command returns the name of the node to which rabbitmqctl has connected.

       rabbitmqctl close_connection "<rabbit@tanto.4262.0>" "go away"
           This command instructs the RabbitMQ broker to close the connection associated with the Erlang process id <rabbit@tanto.4262.0>, passing the explanation go away to the
           connected client.
</pre>

=== Mise en cluster ===

==== Récupérer le nom des nodes ==== 
<pre>
root@bz6:~# rabbitmqctl status | head -n 1
Status of node rabbit@bz6 ...
</pre>

==== Résoudre le noms des nodes ====

Renseigner le nom des node dans /etc/hosts

==== copier le cookie entre les noeuds ====

 scp /var/lib/rabbitmq/.erlang.cookie bz6:/var/lib/rabbitmq/


====rebooter les noeuds====

Sur les noeuds à ajouter

====Stopper les applications==== 
<pre>
root@bz6:~# rabbitmqctl stop_app
Stopping node rabbit@bz6 ...
...done.
</pre>

====Puis joindre le noeud au master==== 
<pre> 
root@bz6:~# rabbitmqctl join_cluster rabbit@bz5
Clustering node rabbit@bz6 with rabbit@z5 ...
...done.
</pre>
==== Vérifier le status du cluster ====

<pre>
root@bz6:~# rabbitmqctl cluster_status
Cluster status of node rabbit@bz6 ...
[{nodes,[{disc,[rabbit@bz5,rabbit@bz6]}]},
 {running_nodes,[rabbit@bz5,rabbit@bz6]},
 {cluster_name,<<"rabbit@bz5.ecritel.net">>},
 {partitions,[]}]
...done.
</pre>

== Utilisation ==

=== pré-requis===
Il faut préalablement installer les outils de manipulation de message :
 apt install amqp-tool

=== lister le contenu d'une file d'attente ===

rabbitmqctl list_queues -p pai_vhost

* -p vhost

=== publier un message ===
amqp-publish --username=pai --password=pai --vhost=pai_vhost  -r toto -b "tagada"

* -r clé de routage
* -b message à transporter

===Lire un message ===

amqp-get --username=pai --password=pai --vhost=pai_vhost -q toto

* -q nom de la file d'attente

== Monitoring ==

Dépôt de check :
http://gitlab.ecritel.net/installs/configurations-repo/blob/master/Linux/Debian/jessie/ECRITEL/ECRITEL/EXPLOITATION/SCRIPTS/monitoring/nagios/check_rabbitmq_overview

Utilisation du check :
<pre>
root@bz3:~# cat /etc/nagios/nrpe.d/rabbitmq-personnalisation.cfg
command[SERVICE_RABBITMQ_OVERVIEW]=/ECRITEL/EXPLOITATION/SCRIPTS/monitoring/nagios/check_rabbitmq_overview -H localhost -u antonio -p antonio
</pre>

== Sauvegarde ==

Petit scarabé, lit la présentation, tu comprendra que cela ne sert à rien ...

== Troubleshooting ==

===Interface graphique=== 
http://ipduserveur:15672/

===CLI===
http://www.rabbitmq.com/management-cli.html


=== Relance, status et arrêt ===

==== Démarrage ====

 systemctl start rabbitmq-server.service

==== Arrêt ====

 systemctl stop rabbitmq-server.service

==== Status ====

 systemctl status rabbitmq-server.service

=== Howto troubleshooting ===

https://www.rabbitmq.com/troubleshooting.html


## lister les queues

```
rabbitmqctl list_queues -p /
```

## export de conf

```
rabbitmqadmin -u admin -p ma export rabbit.config
```

## mise en cluster

!! se mettre en même version rabbitmq et erlang*

```
sur le node à ajouter
```

```
rabbitmqctl stop_app
```

```
rabbitmqctl reset
```
ajout au cluster
```
rabbitmqctl join_cluster rabbit@nomdumaitre
```

```
rabbitmqctl start_app
```
on install le plugin de managment
```
rabbitmq-plugins enable rabbitmq_management
```
