### démarrage
#### générer des clés

`̀ `
gpg --gen-key
`̀ `

#### lister les clés

`̀ `
gpg --list-key
/root/.gnupg/pubring.gpg
------------------------
pub   2048R/C56CE756 2017-03-25
uid                  Kevin Beatnick <Beatnick@micorsoft.com>
sub   2048R/C56CE756 2017-03-25
`̀ `
Et enfin les utiliser dans ducplicity

duplicity --encrypt-key "C56CE756" --sign-key "C56CE756 " /sauvegardes/cyrus-spool/ scp://root@18.289.10.8/sauvegardes/

### changement de la passphrase

