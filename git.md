[cloner une branche spécifique d'un repo]: #cloner
* [cloner une branche spécifique d'un repo][cloner]
* [poussez sa branche pour un merge](#poussez-sa-branche-pour-un-merge)
* [pull de sa branche a partir de la master](#pull-de-sa-branche-a-partir-de-la-master)
* [voir le diff entre deux commits] (#voir-le-diff-entre-deux-commits)

## Doc gitlab
http://docs.gitlab.com/ee/workflow/workflow.html


### voir la branche actuelle
```
git branch
* master
```
### Créer une nouvelle branche s'appellant "pilotage" 
`git branch pilotage`
### y aller
`git checkout pilotage`
### vérifier sa position
```
git branch
* master
  pilotage
```
On n'est bien sur la nouvelle branche 
### setter les variables utilisateurs 
```
git config --global user.name "Pouet Pouet"
git config --global user.email pouet@gruik.fr
```
### commiter les modifs
`git commit -m "add varnish steering(pilotage)"`
### enfin les pousser
`git push`
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
