# make

### mes tabulations ne marchent pas

vous utilisez certainement des ^t au lieu des ^I, donc avec l'option
expandtab dans .vimrc, il faut demander à vim de désactiver ces tabulations lorsque
 l'on écrit un makefile 

https://vi.stackexchange.com/questions/704/insert-tabs-in-insert-mode-when-expandtab-is-set

```bash
" Normal action
set expandtab

if has("autocmd")

    " If the filetype is Makefile then we need to use tabs
    " So do not expand tabs into space.
    autocmd FileType make   set noexpandtab

endif
```
