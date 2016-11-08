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
