### Obtenir le status d'un module 

```bash
php-fpm-cli -connect 127.0.0.1:9000 -r 'print_r(opcache_get_status(false));'
```
