### étendre un LVM ainsi que le FS en une ligne de commande :
```
 lvresize --resizefs --size +5G /dev/mapper/systemvm-var_lib_mysql
 ```