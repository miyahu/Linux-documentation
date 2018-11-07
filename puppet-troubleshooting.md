# Troubleshooting

### vérifier la syntaxe

```bash
bundle exec rake syntax lint metadata_lint check:symlinks check:git_ignore check:dot_underscore check:test_file rubocop
```

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

### Error: Found  dependency cycle

Exemple 

```bash
(File[/etc/postfix/main.cf] => File[/etc/postfix/main.cf])\nTry the '--graph' option and opening the resulting '.dot' file in OmniGraffle or GraphViz
```

La ressource avait une dépendance "auto-référente", elle surveillait le fichier que la fonction copiait.

### top-scope variable being used without an explicit namespace

http://puppet-lint.com/checks/variable_scope/

Il faut associer les variables à l'espace de nom du module :

$postfix::myvar <-- ok
$myvar <-- nok

La seconde définition fonctionne mais emet un warning avec puppet-lint

$::myvar <-- nok : cette syntaxe passe le lint mais génère une erreur lors de l'executation réel de la classe. 


