
### récupérer le binaire

wget  "http://downloads.sourceforge.net/project/plantuml/plantuml.jar?r=http%3A%2F%2Fplantuml.com%2Fdownload&ts=1476968422&use_mirror=heanet" -O plantuml.jar

### le copier dans /usr/local/bin/
```
mv -v plantuml.jar  /usr/local/bin/
```
### préparer lanceur

if [ ! -f /usr/local/bin/plant ] ; then
    sudo sh -c 'echo "java -jar /usr/local/bin/plantuml.jar" >> /usr/local/bin/plant'
fi

### faire un test

cat >/tmp/gruik<<EOF
@startuml
Alice -> Bob: test
@enduml 
EOF

/usr/bin/java -jar /usr/local/bin/plantuml.jar
