1. [Overview][Overview]


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

### Overview
