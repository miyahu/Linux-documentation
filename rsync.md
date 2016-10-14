* [synchroniser deux arbo] (#synchroniser-deux-arbo)

```
nice -n 19 ionice -c2 -n7 rsync -avPz --delete-after /var/exports/uploads/ /media/test/www_wordpress/www/shared/wp-content/uploads/ &>/tmp/out &
```
