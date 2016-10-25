* [installation] (#installation)
* [créer une règle] (#créer-une-règle)
* [lister les règles] (#lister-les-règles)
* [supprimer une règle] (#supprimer-une-règle)

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
