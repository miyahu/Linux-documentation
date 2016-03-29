https://techoverflow.net/blog/2013/08/01/how-to-create-libsodium-nacl-deb-packages/

Environnement de build
```
 apt-get install devscripts debhelper build-essential
```
et 
```
apt-get install dh-make-php php5-dev build-essential libmagic-dev debhelper
```
Avoir la version de l'API php 
```
php-config5 --phpapi
```
https://www.dotdeb.org/2008/09/25/how-to-package-php-extensions-by-yourself/

# j'exporte certaines variables
```
export DEBFULLNAME="gruik"
export DEBEMAIL="gruik@gruik"
```
# j'install la lib "manuellement"
```
pecl install libsodium
```
# je download les sources 
```
pecl donwload libsodium
```
