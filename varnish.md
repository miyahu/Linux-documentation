### rewrite url with Varnish

If you want stripped the left side of uri, ex /blabla/
```
if (req.url ~ "/(\w+)/assets/") {
        set req.url = regsuball(req.url, "/(\w+)/(.*)/" , "/\2/");
       return (pass); 
   }
   ```
   
   Documentation here :
   
   https://www.varnish-cache.org/docs/4.1/users-guide/vcl-syntax.html?highlight=regsub

### varnish et systemd

https://ma.ttias.be/running-varnish-4-x-on-systemd/

### exporter la conf en cours

`varnishadm vcl.show $(varnishadm vcl.list | awk '$0 ~ /active/{print$NF}') > /tmp/out`
