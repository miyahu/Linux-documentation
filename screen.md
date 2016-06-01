référence : http://aperiodic.net/screen/quick_reference
### renommer un onglet

Ctrl+a puis A 

### créer un screen 

```
head -n 20 .screenrc-pouetpouet 
caption always "%{Yb} %02d-%02m-%Y %0c %{k}|%{C} - METEOJOB - %{k}|%{G} %{W}%n %{R}%t"
zombie kr
startup_message off
bell_msg ""
screen -ln -t "(>'-')> Meteojob - MJB <('-'<)"
screen -ln -t "+----------------------------+"
screen -ln -t " doc "
screen -ln -t " -> INVENTAIRE: CF doc !!! "
screen -ln -t "+----------------------------+"
screen -ln -t " "
screen -ln -t "----- [ LVS ] -"
screen -ln -t "lvs1 [Primaire]"
screen -ln -t "lvs2 [Secondaire]" ssh 10.0.32.2
screen -ln -t " "
screen -ln -t " "
screen -ln -t "----- [ HYP ] -"
screen -ln -t "mjbs6 [ Xen - Relay mail]" ssh mjbs6
screen -ln -t "mhyp1 [ Proxmox ]" ssh mjbhyp1
screen -ln -t "mhyp2 [ Proxmox ]" ssh mjbhyp2
screen -ln -t "mhyp3 [ Proxmox ]" ssh mjbhyp3
``` 
### le charger 

`screen -c .screenrc-pouetpouet -S pouetpouet`

### terminer une instance 

`Ctrl+a puis :quit`

### relire la conf d'une instance 

`Ctrl+a puis :source ~/.screenrc`
