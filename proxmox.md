### rediriger tous les ports VNC d'une  VM vers un port unique

https://pve.proxmox.com/wiki/Vnc_2.0

### message suivant 
`
TASK [mox : Remove volatile proxmox API and Forman API auth conf file] *********
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: AttributeError: 'list' object has no attribute 'startswith'
fatal: [localhost]: FAILED! => {"changed": false, "failed": true, "parsed": false}
`

Il y a un doublon, par exemple que proxmox qui répond au même nom
