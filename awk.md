### filtrer les IP

``̀
nslvs11:~# iptables-save | awk '$12 ~ /8044/ && $4 ~ /(42.1.210.216|42.4.166.31|79.31.150.70)/ {print}'
-A INPUT -s 42.1.210.216/32 -d 89.31.150.71/32 -p tcp -m tcp --dport 8044 -j ACCEPT
-A INPUT -s 42.4.166.31/32 -d 89.31.150.71/32 -p tcp -m tcp --dport 8044 -j ACCEPT
-A INPUT -s 79.31.150.70/32 -d 89.31.150.71/32 -p tcp -m tcp --dport 8044 -j ACCEPT
``̀
