      * [Doc gitlab](#doc-gitlab)
         * [git et les branches](#git-et-les-branches)
            * [voir la branche actuelle](#voir-la-branche-actuelle)
            * [Créer une nouvelle branche s'appellant "pilotage"](#créer-une-nouvelle-branche-sappellant-pilotage)
            * [y aller](#y-aller)
            * [vérifier sa position](#vérifier-sa-position)
            * [setter les variables utilisateurs](#setter-les-variables-utilisateurs)
            * [commiter les modifs](#commiter-les-modifs)
            * [enfin les pousser](#enfin-les-pousser)
         * [cloner une branche spécifique d'un repo](#cloner-une-branche-spécifique-dun-repo)
         * [afficher la liste des commits](#afficher-la-liste-des-commits)
         * [afficher un commit (ainsi que son diff)](#afficher-un-commit-ainsi-que-son-diff)
         * [voir les différences entre 2 branches](#voir-les-différences-entre-2-branches)
      * [poussez sa branche pour un merge](#poussez-sa-branche-pour-un-merge)
      * [pull de sa branche a partir de la master](#pull-de-sa-branche-a-partir-de-la-master)
         * [voir le diff entre deux commits](#voir-le-diff-entre-deux-commits)
         * [créer une branche à la volée](#créer-une-branche-à-la-volée)
         * [supprimer une modification sur un fichier gité mais commité](#supprimer-une-modification-sur-un-fichier-gité-mais-commité)
         * [supprimer un commit non pushé](#supprimer-un-commit-non-pushé)
         * [connaitre l'historique des modifications d'un fichier](#connaitre-lhistorique-des-modifications-dun-fichier)
         * [pousser un commit en particulier](#pousser-un-commit-en-particulier)
         * [retourner un fichier à un commit donné](#retourner-un-fichier-à-un-commit-donné)
         * [retrouver une ancienne version de fichier](#retrouver-une-ancienne-version-de-fichier)
         * [ignorer des fichiers déjà ajouté (sans les supprimer)](#ignorer-des-fichiers-déjà-ajouté-sans-les-supprimer)

# git

## principe et remarque

ne jamais créer de branche en production, car losque l'on va dessus, c'est celle-ci qui devient active

## Doc gitlab
http://docs.gitlab.com/ee/workflow/workflow.html

### git et les branches

#### voir la branche actuelle
```
git branch
* master
```
#### Créer une nouvelle branche s'appellant "pilotage" 
`git branch pilotage`
#### y aller
`git checkout pilotage`
#### vérifier sa position
qu'on soit  bien sur la nouvelle branche 
```
git branch
    master
*  pilotage
```
#### setter les variables utilisateurs
```
git config --global user.name "Pouet Pouet"
git config --global user.email pouet@gruik.fr
```
#### commiter les modifs
`git commit -m "add varnish steering(pilotage)"`
#### enfin les pousser
`git push origin pilotage`
### cloner une branche spécifique d'un repo
`git clone -b release2.0.0  git@git.ateway.fr:ansibleroles/aw-apache.git`

### afficher la liste des commits

`git log`

### afficher un commit (ainsi que son diff) 
 la dernière string est le n° de commit
 
`git show 79e3efa2c4e87cb8bf4590ac13278b3e71a286b3̀ 

### voir les différences entre 2 branches
`git diff master pilotage`

## poussez sa branche pour un merge
`git push origin fix-1.6`

## pull de sa branche a partir de la master

`git branch --set-upstream-to=origin/master antonio-vhost`

### voir le diff entre deux commits

obtenir le nom des commit avec `git log`
puis afficher le diff avec
`git diff 9d9d1d1943f23e975f4779505adde05f54f18949 efb0404b06f0665dd1f548a142c1429afefa19b6`


### créer une branche à la volée

`git fetch origin master:mafeature`


En faite idéalement :

1. tu créer une branch qui sera ta feature a partir du master de l'origin :
git fetch origin master:mafeature

2. tu va dessus
git checkout mafeature

3. tu tafff et tu commit pour valider.

4 tu fusionne tes commis pour éviter les commits genre "test test test ...." pour a voir un commit qui est un sens 🙂

git rebase -i origin/master
>squash tout les commits (sauf le premier)
> tu réécrit ton message cf : gitchangelog
5. tu push ta branch pour un merge;
git push origin mafeature

oui, le gitignore ce git
tant qu'il n'est pas commité, il ne s'applique pas pour les prochain commit

### supprimer une modification sur un fichier gité mais commité

`git checkout -- data/system/all/hosts.j2`

### supprimer un commit non pushé

`git reset --hard HEAD~1`

### connaitre l'historique des modifications d'un fichier

`git log -p group_vars/ppdweb/rsyslog.yml`

### pousser un commit en particulier

`git push origin  fb459a826f7fc1d80f88d3e05ffe723790b8977c:mabranch`

### retourner un fichier à un commit donné

retrouver le n° de commit
`git log mon_fichier`

revenir dessus
`git checkout b13b7485887dfe655fbf03a30476c91228b9e7ea mon_fichier`

### retrouver une ancienne version de fichier

Utiliser git log pour retrouver le commit qui nous intérèsse

puis utiliser git show
```
git show 96ff0b28092a3f113f0f4e35730f54ea50042847:create_new_site.sh
```

### ignorer des fichiers déjà ajouté (sans les supprimer)

```bash
git rm --cached
```

### localement récupérer les commits de master

```bash
git pull . master 
```



