# Lister les alternatives
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
 
Explication de la colonne **Priority** :
(tiré de la manpage) Quand un groupe de liens est en mode automatique, l'alternative visée par les éléments du groupe est celle qui possède la priorité la plus élevée.


