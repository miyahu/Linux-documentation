### répertorier les hôsts actifs sur le port 22 avec doscan
```
doscan -i -p 22  10.2.0.0/23 --output %a
```

### obtenir la liste des réseaux attachés à sa machine

```
for i in $(hostname -I | sort | uniq) ; do  
    doscan -i -p 22 $(ipcalc -b -n $i | awk '/Network:/ {print$NF}') --output %a > /tmp/${i/\/*/} ;
done
```

### utiliser le fichier host pour résoudre les IPs locals

```
while read line ; do
    awk -v myline=$line '$0 ~ myline && gsub("\.toto\.net","")  {print$2}' /etc/hosts ; 
done < /tmp/10.0.16.252
```

