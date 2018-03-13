* [charger en mémoire le mot de passe ssh] (#charger-en-mémoire-le-mot-de-passe-ssh) 
* [contrôle d'accès par ip] (#contrôle-d'accès-par-ip) 
* [perf]

### charger en mémoire le mot de passe ssh

```bash
ssh-agent bash
ssh-add
```

### téléchargement avec reprise

From https://stackoverflow.com/questions/26411225/how-to-resume-scp-with-partially-copied-files

```bash
cd /home/ronron22/Bureau/videos/ &&
echo "get -a /media/*" | sftp -P2224 -l 2000 2.42.134.12
```
### contrôle d'accès par ip

```
 grep -vE "^(#|$)" /etc/hosts.*
/etc/hosts.allow:sshd: localhost
/etc/hosts.allow:sshd: 9.31.149.18
/etc/hosts.allow:sshd: 9.85.27.13
/etc/hosts.deny:sshd: ALL EXCEPT LOCAL
```

### Tips

http://blogs.perl.org/users/smylers/2011/08/ssh-productivity-tips.html

### transferer sa clef ssh

vérifier que la clef est ben chargée dans le ssh-agent 
```bash
ssh-add -l
```
connectez-vous à une autre machine
```bash
ssh -A toto
```
revérifier
```bash
ssh-add -l
```

