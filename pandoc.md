# Migration de Mediawiki vers Github 
Nous l'installons via *cabale* 
```
apt-get install cabal-install
```
Nous faisons ce que le fichier INSTALL nous demande
```
cabal update
cabal install pandoc
 ```
Par défaut, l'executable est installé dans 
```
~/.cabal/bin/pandoc
```
Et enfin on transforme
```
pandoc -r mediawiki /tmp/in -t markdown -o /tmp/ou
````
Ou :
* -r format d'entrée
* -t format de sortie
* -o fichier de sortie
