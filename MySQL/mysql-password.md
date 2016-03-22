```
mysql> grant all privileges on test.* to test@localhost identified by 'password';
ERROR 1827 (HY000): The password hash doesn't have the expected format. Check if the correct password algorithm is being used with the PASSWORD() function.
```

ERROR 1827 (HY000): The password hash doesn't have the expected format

Il faut utiliser un hash généré avec une fonction plus récente de MySQL (sur une machine récente) ou, désactiver les old_password avec un 

from http://m.blog.itpub.net/23249684/viewspace-1462818/

 ```
 mysql> show variables like 'old_passwords';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| old_passwords | 1     |
+---------------+-------+
1 row in set (0.01 sec)

mysql> set old_passwords=0;
Query OK, 0 rows affected (0.00 sec)


mysql> grant all privileges on goolen.* to root@'%' identified by '123456';
Query OK, 0 rows affected (0.02 sec)
```
