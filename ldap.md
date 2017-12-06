* [filtre ldap] (#filtre-ldap)
* [obtenir le mail des admins présents sur paris] (#obtenir-le-mail-des-admins-présents-sur-paris) 

### filtre ldap
https://confluence.atlassian.com/display/DEV/How+to+write+LDAP+search+filters

###  obtenir le mail des admins présents sur paris
```
(&(l=Paris)(title=*Admin*))
```

```
ldapsearch -x -H ldap://ldap.tagada.com -s sub -D 'cn=tagada,ou=Users,dc=tagada,dc=com' -b "dc=tagada,dc=com" -W -LLL  "(&(l=Paris)(title=*Admin*))" mail
```

### tester qu'un mot de passe est bon

```bash
ldapwhoami -x -w "pouet" -D uid=kevin,ou=People,dc=microtruc,dc=com  -H ldap://localhost:389/
```

