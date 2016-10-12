
* [renommer un onglet] (#renommer-un-onglet)
* [créer un screen] (#créer-un-screen)
* [charger un screenrc] (#charger-un-screenrc)
* [terminer une instance] (#terminer-une-instance)
* [relire la conf d'une instance] (#relire-la-conf-d'une-instance)

référence : http://aperiodic.net/screen/quick_reference
### renommer un onglet

Ctrl+a puis A 

### créer un screen 

```
cat .screen-rc-inframetric 
caption always "%{Yb} %02d-%02m-%Y %0c %{k}|%{C} INFLUXDB/GRAFANA %{k}|%{G} %{W}%n %{R}%t"
zombie kr
defutf8 on

screen -t "metric1" ssh metric1
screen -t "metric2" ssh metric2
``` 
### charger un screenrc

``` 
screen -c .screenrc-pouetpouet -S pouetpouet
``` 

### terminer une instance 

`Ctrl+a puis :quit`

### relire la conf d'une instance 

`Ctrl+a puis :source ~/.screenrc`
