* [compresser les fichiers non compressés] (#compresser-les-fichiers-non-compressés)

### compresser les fichiers non compressés
```
for i in */*/* ; do if ! [[ $i =~ ".gz" ]] ; then  gzip $i ; fi  ; done
```
