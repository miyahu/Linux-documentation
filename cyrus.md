### restauration d'email

lancer un reconstruct de la mailbox, 

Se connecter
``̀
cyradm  --user antonio --authz antonio  localhost
``̀
Lister les boite de l'utilisatrice
``̀
localhost> lm user.sylvie*
user.sylvie (\HasChildren)                         
user.sylvie.Archives (\HasNoChildren)
``̀
créer un dossier de restauration
``̀
cm user.sylvie.restauration
``̀
copier les mail 
il faut quitter cyradm pour cela

``̀
cp -aiv /tmp/restau-sylvie/*. /var/spool/cyrus/mail/s/user/sylvie/restauration/
`̀

puis lancer le reconstruct, sinon, les emails ne seront pas visible
``̀
reconstruct user.sylvie.restauration
``̀

