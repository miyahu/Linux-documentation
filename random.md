
### generate random

From Serverfault

```bash
apt-get -y install rng-tools && \
rngd -r /dev/urandom
```

### virtual dés
générer un résultat entre 1 et 6 (jouer au dès)

From Serverfault

```bash
shuf -i 1-6 -n 1
```

### installer un démon générateur d'antropie


```bash
apt install haveged
```
