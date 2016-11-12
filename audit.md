* [installation] (#installation)
* [créer une règle] (#créer-une-règle)
* [lister les règles] (#lister-les-règles)
* [supprimer une règle] (#supprimer-une-règle)
* [obtenir le numéro d'un appel système] (#obtenir-le-numéro-d'un-appel-système)
* [tracer les accès d'un programme] (#tracer-les-accès-d'un-programme)
* [problème avec arch] (#problème-avec-arch)
* [lister les suppressions faites dans /var/gruik] (#lister-les-suppressions-faites-dans-/var/gruik)

## audit des évenements fs  

### installation

```
apt install auditd
```
### créer une règle
Je veux savoir qui supprime les fichiers dans le répertoire /tmp/gruik

```
auditctl -w /tmp/gruik -p w -k gruik-file

```
### lister les règles

```
auditctl -l
LIST_RULES: exit,always watch=/etc/passwd perm=rwa key=password-file
LIST_RULES: exit,always dir=/tmp/gruik (0xa) perm=rwa key=tagada
```
### supprimer une règle
```
auditctl -d exit,always -F path=/etc/passwd -F perm=rwa -F key=password-file
```
### obtenir le numéro d'un appel système
```
ausyscall x86_64 unlink --exact
87
```

### tracer les accès d'un programme
```
auditctl -D
autrace /bin/ls /tmp
```

### problème avec arch
Utiliser
```
-F arch=x86_64 
```

### lister les suppressions faites dans /var/gruik

```
ausearch -k lbh-delete1 -sc 84 -sc 263 -sc 87 -f /var/gruik
```
