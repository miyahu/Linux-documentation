# nginx

### redirection/réécriture sur des options php

La **rewrite** normale ne passera pas si des arguments sont donnés à php 


```bash
    location ~ ^/static.php {
        if ($args ~* "show=tos&lang=fr") { set $args ''; rewrite ^.*$ /fr/pouet-truc permanent; }
    }
```

> La gestion des "?" dans nginx semble (je confirme) nécessiter l'utilisation de la structure $arg qui contient les options php

```bash
$args
 arguments in the request line
```

> https://stackoverflow.com/questions/44782411/nginx-rewrite-question-mark
> https://serverfault.com/questions/513171/nginx-rewrite-with-a-question-mark

