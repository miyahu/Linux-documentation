# Linux-documentation

## Munin vs Nginx

Configuration Nginx 

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
                fastcgi_pass unix:/var/run/munin/spawn-fcgi-munin-graph.sock;
                include fastcgi_params;
        }
