* (supprimer des répertoire tout'en en excluant)

# bash

### supprimer des répertoire tout tant en excluant

http://stackoverflow.com/questions/4325216/rm-all-files-except-some

Test
```
mkdir /tmp/toto/{tata,titi,tutu} && cd /tmp/toto/
 shopt -s extglob
rm -ri !(tutu)
rm : supprimer répertoire « tata » ? y
rm : supprimer répertoire « titi » ? y
```

### ventiler un vhost monolithique dans de multiples fichiers

#### split sur motif
csplit -f 'virtualhost-' -b '%03d.conf' my-monolithic-file  '/^ *<VirtualHost /' '{*}'

### un prompt de compète

```bash
print_branch_name() {
        if [ -z "$1" ]
        then
                curdir=`pwd`
        else
                curdir=$1
        fi

        if [ -d "$curdir/.hg" ]
        then
                echo -n " "
                if [ -f  "$curdir/.hg/branch" ]
                then
                        cat "$curdir/.hg/branch"
                else
                        echo "default"
                fi
                return 0
                elif [ -d "$curdir/.git" ]
                then
                        echo -n " "
                        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
                fi

        # Recurse upwards
        if [ "$curdir" == '/' ]
        then
                return 1
        else
                print_branch_name `dirname "$curdir"`
        fi
}

        e=\\\033
        export PS1="\[$e[1;36m\][\u@\h \t]\[$e[1;33m\]\$(print_branch_name) \[$e[0m\]\w\n\[$e[1;37m\]——> \[$e[0m\]"
```

### export une fonction 

```bash
export -f nom_de_ma_fonction
```

### renommer tous les .txt en .md

```bash
 for i in *.txt ; do mv -vi $i  ${i/txt/md} ; done
```

### code à étudier

https://unix.stackexchange.com/questions/70966/how-to-suppress-bash-octal-number-interpretation-to-be-interpreted-as-decimal

setting des variables à la volée

```bash
eval $(date +"h=%H m=%M")
h=${h#0}
m=${m#0}
echo say "$h hours and $m minutes"
```

### fonction de backup

```bash
cpb () 
{ 
    ( test -d ~/workspace || mkdir ~/workspace;
    test -z "$1" && echo "submit file or directory please";
    fullpath="$(dirname $(readlink -f "$1"))";
    mydate="$(date +%F_%R-backup)";
    fullpath="~/workspace/${mydate}-${fullpath#'/'}";
    mkdir -p "$fullpath";
    cp -va "$1" "$fullpath" )
}
```
