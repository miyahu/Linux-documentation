* [charger en mémoire le mot de passe ssh] (#charger-en-mémoire-le-mot-de-passe-ssh) 

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

