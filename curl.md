### Tester la compression

Pour tester la compression, il faut insérer un entête disant le type de compression acceptée, exemple :
sans entête Accept-encoding
̀``̀
curl  -I -H "Host: www.tagada.com" localhost:6080/json-list/
HTTP/1.1 200 OK
Server: nginx
Content-Type: application/json
Connection: close
Cache-Control: no-cache
Date: Mon, 18 Apr 2016 09:23:26 GMT
X-Vhost-Id: www-2016.orpi.com
̀``

Avec entête Accept-encoding
̀``̀̀`
curl -H "Accept-encoding: "gzip, deflate"" -I -H "Host: www.tagada.com" localhost:6080/json-list/
HTTP/1.1 200 OK
Server: nginx
Content-Type: application/json
Connection: close
Cache-Control: no-cache
Date: Mon, 18 Apr 2016 09:19:52 GMT
X-Vhost-Id: www-2016.orpi.com
Content-Encoding: gzip
̀````
