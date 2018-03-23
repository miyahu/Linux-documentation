### installer un plugin
```
vagrant plugin install vagrant-lxc
```
### lister les plugins 
```
vagrant plugin list
No plugins installed.
```
### initialiser et démarrer 

`vagrant init debian/jessie64; vagrant up --provider lxc`

### lister les box disponibles

```bash
vagrant box list
```

### arrêter les machines

```bash
vagrant halt
```

### voir les instances activent

```bash
vagrant global-status
```

### ajouter une box

exemple

```bash
vagrant box add debian/stretch64
vagrant box add debian/contrib-stretch64
```

