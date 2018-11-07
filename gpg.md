# gpg

https://linuxconfig.org/how-to-encrypt-and-decrypt-individual-files-with-gpg

## chiffrement d'un fichier

```bash
gpg -e -r "Your Name" myfile
```

### déchiffrement

```bash
gpg -d myfile
```

### listing des clefs

```bash
gpg --list-secret-keys
```

### envoi de la clef sur les serveurs

```bash
gpg --send-keys FFTTDDD
```

### sauvegarde et restauration

https://msol.io/blog/tech/back-up-your-pgp-keys-with-gpg/


