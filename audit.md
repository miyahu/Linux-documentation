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

```bash
apt install auditd
```
### créer une règle

Je veux savoir qui supprime les fichiers dans le répertoire /tmp/gruik

```bash
auditctl -w /tmp/gruik -p w -k gruik-file

```
### lister les règles

```bash
auditctl -l
LIST_RULES: exit,always watch=/etc/passwd perm=rwa key=password-file
LIST_RULES: exit,always dir=/tmp/gruik (0xa) perm=rwa key=tagada
```
### supprimer une règle

```bash
auditctl -d exit,always -F path=/etc/passwd -F perm=rwa -F key=password-file
```
### obtenir le numéro d'un appel système

https://filippo.io/linux-syscall-table/

```bash
ausyscall x86_64 unlink --exact
87
```

### tracer les accès d'un programme

```bash
auditctl -D
autrace /bin/ls /tmp
```

### problème avec arch

Utiliser

```bash
-F arch=x86_64 
```

### lister les suppressions faites dans /var/gruik

```bash
ausearch -k lbh-delete1 -sc 84 -sc 263 -sc 87 -f /var/gruik
```

### exclure des répertoires

https://www.redhat.com/archives/linux-audit/2011-November/msg00054.html
