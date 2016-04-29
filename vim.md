### Supprimer une plage de lignes

Par exemple supprimer la plage de 100 à 150 

Ouvrir vim puis :100,150d 


### ouvrir un fichier à une ligne en particulier
```
vim +35 mon_fichier
```
### avoir des tabulations de 4 espaces
ajouter cela à son vimrc
```
" For everything else, use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.
```