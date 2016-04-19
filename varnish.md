### rewrite url with Varnish

If you want stripped the fist uri string ex /blabla/
```
if (req.url ~ "/(\w+)/assets/") {
        set req.url = regsuball(req.url, "/(\w+)/(.*)/" , "/\2/");
       return (pass); 
   }
   ```
