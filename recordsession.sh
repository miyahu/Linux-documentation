cat  /etc/profile.d/recordsession.sh 
#!/bin/bash -

if (( $UID == 0 )); then
        /usr/bin/script -a /root/sessions/script-$(date +%Hh%M-%d-%m-%y).out
fi
