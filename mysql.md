#  MySQL

## upgrade 5.6 vers 5.7

erreur lors du dump de l'information_schema

̀``bash
mysqldump: Couldn't execute 'SELECT /*!40001 SQL_NO_CACHE */ * FROM `GLOBAL_STATUS`': The 'INFORMATION_SCHEMA.GLOBAL_STATUS' feature is disabled; see the documentation for 'show_compatibility_56' (3167)
̀``

̀``bash
set global show_compatibility_56 = on ;
̀``

cat /etc/mysql/conf.d/nv.cnf
[mysqld]
show_compatibility_56 = on

