# gpg

https://linuxconfig.org/how-to-encrypt-and-decrypt-individual-files-with-gpg


## chiffrement d'un fichier

gpg -e -r "Your Name" myfile

### déchiffrement

gpg -d myfile

### listing des clefs

gpg --list-secret-keys

### envoi de la clef sur les serveurs

gpg --send-keys FFTTDDD


