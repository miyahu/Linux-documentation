# Linux-documentation

## éxecuter un plugin

 Utiliser munin-run
```
 munin-run  dovecot
```

## recréer les liens manquants 
```
eval "$(munin-node-configure --shell 2>&1 | grep -E "^ln")
```

## Munin vs Nginx

Recette de cuisine 

###Configuration Nginx 

Configurer fastcgi pour attaquer le socket Unix du process spawn-fcgi

        location /munin {
                alias /var/cache/munin/www;
                index index.html;
                access_log   off;
                allow   127.0.0.1;
                allow   277.256.110.0/24;
                deny all;
        }

        location ^~ /munin-cgi/munin-cgi-graph/ {
                access_log off;
                fastcgi_split_path_info ^(/munin-cgi/munin-cgi-graph)(.*);
                fastcgi_param PATH_INFO $fastcgi_path_info;
                fastcgi_pass unix:/var/run/munin/fcgi-munin-graph.sock;
                include fastcgi_params;
        }


### spawn-fcgi
        apt install spawn-fcgi

débugger spawn-fcgi :

        spawn-fcgi -n -s /var/run/munin/spawn-fcgi-munin-graph.sock \
        -U www-data -u munin -g munin /usr/lib/munin/cgi/munin-cgi-graph
        
        
spawn-fcgi et systemd

        cat  /etc/systemd/system/fastcgi-munin.service
        [Unit]
        Description=FastCGI spawner for Munin cgi

        [Service]
        User=munin
        Group=www-data
        StandardError=syslog
        Type=forking
        Restart=on-abort
        SyslogIdentifier=fastcgi-munin
        ExecStartPre=/bin/rm -f /var/run/fastcgi-munin.pid
        ExecStartPre=/bin/rm -f /var/run/munin/fcgi-munin-graph.sock
        ExecStart=/usr/bin/spawn-fcgi -s /var/run/munin/fcgi-munin-graph.sock -U www-data -u munin -g munin /usr/lib/munin/cgi/munin-cgi-graph -M 0770

        [Install]
        WantedBy=multi-user.target

### erreur dynazoom

Ajouter Allow from all à la directive /munin-cgi/munin-cgi-graph
```bash 
apt-get install libcgi-fast-perl
```

### Troubleshoot local

```bash
munin-run df
```

```bash
munin-run df config
```

### Troubleshoot remote

```bash
munin-run df
```

