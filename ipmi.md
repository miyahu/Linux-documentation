* [reboot via ipmi] (#reboot-via-ipmi)
* [modifier la conf ip de ilo en cli] (#modifier-la-conf-ip-de-ilo-en-cli)


## reboot via ipmi
```
 ipmitool -H 10.10.132.XYZ -C3 -I lan -U tagada shell
Password: 
ipmitool> power status
Chassis Power is on
ipmitool>power reset
```

## modifier la conf ip de ilo en cli

```
hponcfg
```

