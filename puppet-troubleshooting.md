# Troubleshooting

## DSL

### duplicate declaration dans une iteration **each**

L'iteration va dupliquer le nom de la ressource, une erreur "circulaire" apparaîtra du genre

*duplicate on .. line 23  with on .. ligne 23*

Solution

Par exemple faire varier le nom en le suffixant de la variable issue de l'itération

Exemple

```bash
$db_files.each |String $dbfile| {
      exec {"postfix.${dbfile}":
        command => "/usr/sbin/postmap ${configuration_directory}/${dbfile}",
        path        => ['/usr/bin', '/usr/sbin'],
        subscribe   => File["/etc/postfix/${dbfile}"],
        refreshonly => true,
      }
    }
```

## r10k

utiliser le mode verbeux

```bash
r10k deploy environnement -t -v
```

### fatal: could not read Username for 'https://github.com': No such device or address

```bash
ERROR	 -> Command exited with non-zero exit code:
Command: git --git-dir /var/cache/r10k/https---github.com-ronron22-puppet-module-ssh fetch origin --prune
Stderr:
fatal: could not read Username for 'https://github.com': No such device or address
Exit code: 128
```

Le dépôt n'existe plus, vérifier qu'il n'y a plus de référence sur le *Puppetfile* de **TOUTES** les branches !!

 




