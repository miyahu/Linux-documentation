* (supprimer des répertoire tout'en en excluant)

### supprimer des répertoire tout'en en excluant

http://stackoverflow.com/questions/4325216/rm-all-files-except-some

Test
```
mkdir /tmp/toto/{tata,titi,tutu} && cd /tmp/toto/
 shopt -s extglob
rm -ri !(tutu)
rm : supprimer répertoire « tata » ? y
rm : supprimer répertoire « titi » ? y
```
