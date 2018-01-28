### après avoir modifié un service systemd

`systemctl daemon-reload`

### /etc/systemd vs /usr/lib/systemd

* /etc/systemd accueil les services personnalisés

* /lib/systemd accueil les services standard 

### voir une "unit"

```bash
systemctl cat "unit"
```

### personnaliser une "unit" 

```bash
systemctl edit "unit"
```

puis ajouter ses éléments

Ce fichier apparaitra dans **/etc/systemd/system/"unit.d"/override.conf**
