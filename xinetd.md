### rediriger une connexion tcp


Installer xinetd, puis ajouter le service imap puis

`̀``
service imap
{
 disable = no
 type = UNLISTED
 socket_type = stream
 protocol = tcp
 wait = no
 redirect = 62.172.24.10 143
 bind = 10.100.0.21
 port = 143
 user = nobody
}
`̀``
