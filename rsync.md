* [synchroniser deux arbo] (#synchroniser-deux-arbo)

```
nice -n 19 ionice -c2 -n7 rsync -avPz --delete-after /var/exports/uploads/ /media/test/www_wordpress/www/shared/wp-content/uploads/ &>/tmp/out &
```

en plus

* --preallocate : alloue avant d'écrire
* --delete-after : supprime après transfert (et pas avant)
* --partial : garde les fichiers partiellement transférés (en cas de coupure)
