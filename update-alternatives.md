## Obtenir la liste de tous les choix 
```
update-alternatives --get-selections
```
## Séléctioner une alternative (mode interractif)
```
update-alternatives --config editor
There are 3 choices for the alternative editor (providing /usr/bin/editor).

  Selection    Path                Priority   Status
------------------------------------------------------------
  0            /bin/nano            40        auto mode
  1            /bin/nano            40        manual mode
* 2            /usr/bin/vim.basic   30        manual mode
  3            /usr/bin/vim.tiny    10        manual mode
  ```
La colonne **Status** peut adopter les valeurs suivantes :
* auto mode : status par défaut, update-alternatives décide
* manual mode : explicitement modifié par root (ou un installer)
 
la colonne **Priority** :
* (tiré de la manpage) Quand un groupe de liens est en mode automatique, l'alternative visée par les éléments du groupe est celle qui possède la priorité la plus élevée.

## Séléctioner une alternative (One liner)
```
 update-alternatives --set editor /usr/bin/vim.basic
 ```
 
## Créer une alternative
```
update-alternatives --install /usr/sbin/tagada  tagada /usr/bin/vim 50
```
## exceptions
attention, certains programmes gère tout seul l'éditeur utilisé via la prise en compte de la variable EDITOR et VISUAL, ex vipw 

