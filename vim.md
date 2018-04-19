### Supprimer une plage de lignes

Par exemple supprimer la plage de 100 à 150 

Ouvrir vim puis :100,150d 


### ouvrir un fichier à une ligne en particulier
```
vim +35 mon_fichier
```
### avoir des tabulations de 4 espaces


ajouter cela à son .vimrc

```bash
set  tabstop =4
set  shiftwidth =4
set  softtabstop =4
```
### commenter plusieurs lignes à la fois

http://stackoverflow.com/questions/2276572/how-do-you-do-block-comment-in-yaml

http://stackoverflow.com/questions/1676632/whats-a-quick-way-to-comment-uncomment-lines-in-vim

```
" For everything else, use a tab width of 4 space chars.
To comment out blocks in vim:

press Esc (to leave editing or other mode)
hit ctrl+v (visual block mode)
use the up/down arrow keys to select lines you want (it won't highlight everything - it's OK!)
Shift+i (capital I)
insert the text you want, i.e. '% '
press Esc
Give it a second to work.
```
" For everything else, use a tab width of 4 space chars.

### revenir en avant

Ctrl+r

### le collage décale les lignes en yaml

```bash
set paste
```

### ouvrir un fichier sur la première occurence d'une recherche

http://www.tech-recipes.com/rx/3162/open-vim-editor-to-first-occurrence-of-search-term/

```bash
vi +/searchterm filename
``

###  avec curseur sur la ligne 

https://ensiwiki.ensimag.fr/index.php?title=Vimrc_minimal#Auto_folding_des_fonctions

```bash
set  cursorline
```



