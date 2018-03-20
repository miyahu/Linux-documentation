# fpm

## présentation

fpm ne permet pas de compiler les sources, il faut le faire à la main.

### exemple de compilation

/opt/puppetlabs/puppet/bin/fpm -s dir -t deb -n nodejs -v 8.10.0 -C /tmp/installdir   -p nodejs_VERSION_ARCH.deb   -d "libssl1.1 > 0"   -d "libstdc++6 >= 6.3.0"   usr/bin usr/lib
 

### Executer des scripts de post-install 

--after-install

```bash
cat > afterinstall.sh<<EOF
#!/bin/sh
set -e
ln -s /usr/bin/node /usr/bin/nodejs
chmod a+x /usr/lib/node_modules/npm/bin/npm-cli.js
EOF
```

### Executer des scripts de post-uninstall 

Les fichiers créés en post-install devront être nettoyer par un script de post-uninstall

```bash
cat > postuninstall.sh<<EOF
#!/bin/sh
set -e
test -e /usr/bin/nodejs && rm -f /usr/bin/nodejs
EOF



