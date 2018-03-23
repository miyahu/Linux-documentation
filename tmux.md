* [changer l'organisation des panels](#changer-l-organisation-des-panels)
* [augmenter la taille d'un panel](#augmenter-la-taille-d'-un-panel)
* [attacher à la session](#attacher-à-la-session)
* [spliter](#spliter)
* [scritp de lancement](#scritp-de-lancement)
* [tmux.conf](#tmux.conf)
* redessiner l'écran

### redessiner l'écran à la connexion

tmux a -d

## changer l'organisation des panels
`Ctrl+b+espace`

## augmenter la taille d'un panel
`Ctrl+b puis Alt+flèche direction du pavé numérique`

## attacher à la session
`tmux a`

## spliter

horizontalement : Ctrl+b+%

verticalement : Ctrl+b+"

## scritp de lancement

From http://stackoverflow.com/questions/5609192/how-to-set-up-tmux-so-that-it-starts-up-with-specified-windows-opened

```
tmux new-session -d -s 'gruik' -c '/home/antonio/Bureau' -n 'VOLUME' 'alsamixer'
tmux new-window -n 'FILMS' -c '/media/data/antonio/antonio/films/'
tmux new-window -n 'COMMON' ''
tmux split-window -v ''
tmux split-window -h
tmux new-window -n 'ROOT' 'su -'
tmux selectw -t 2

tmux -2 attach-session -d
```

## tmux.conf

From : http://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/

```
######################
### DESIGN CHANGES ###
######################

unbind C-b
set-option -g prefix C-s
bind-key C-s send-prefix


# panes
set -g pane-border-fg black
set -g pane-active-border-fg brightred

## Status bar design
# status line
set -g status-utf8 on
set -g status-justify left
set -g status-bg default
set -g status-fg colour12
set -g status-interval 2

# messaging
set -g message-fg black
set -g message-bg yellow
set -g message-command-fg blue
set -g message-command-bg black

#window mode
setw -g mode-bg colour6
setw -g mode-fg colour0

# window status
setw -g window-status-format " #F#I:#W#F "
setw -g window-status-current-format " #F#I:#W#F "
setw -g window-status-format "#[fg=magenta]#[bg=black] #I #[bg=cyan]#[fg=colour8] #W "
setw -g window-status-current-format "#[bg=brightmagenta]#[fg=colour8] #I #[fg=colour8]#[bg=colour14] #W "
setw -g window-status-current-bg colour0
setw -g window-status-current-fg colour11
setw -g window-status-current-attr dim
setw -g window-status-bg green
setw -g window-status-fg black
setw -g window-status-attr reverse

# Info on left (I don't have a session display for now)
set -g status-left ''

# loud or quiet?
set-option -g visual-activity off
set-option -g visual-bell off
set-option -g visual-silence off
set-window-option -g monitor-activity off
set-option -g bell-action none

set -g default-terminal "screen-256color"

# The modes {
setw -g clock-mode-colour colour135
setw -g mode-attr bold
setw -g mode-fg colour196
setw -g mode-bg colour238

# }
# The panes {

set -g pane-border-bg colour235
set -g pane-border-fg colour238
set -g pane-active-border-bg colour236
set -g pane-active-border-fg colour51

# }
# The statusbar {

set -g status-position bottom
set -g status-bg colour234
set -g status-fg colour137
set -g status-attr dim
set -g status-left ''
set -g status-right '#[fg=colour233,bg=colour241,bold] %d/%m #[fg=colour233,bg=colour245,bold] %H:%M:%S '
set -g status-right-length 50
set -g status-left-length 20

setw -g window-status-current-fg colour81
setw -g window-status-current-bg colour238
setw -g window-status-current-attr bold
setw -g window-status-current-format ' #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F '

setw -g window-status-fg colour138
setw -g window-status-bg colour235
setw -g window-status-attr none
setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '

setw -g window-status-bell-attr bold
setw -g window-status-bell-fg colour255
setw -g window-status-bell-bg colour1

# }
# The messages {

set -g message-attr bold
set -g message-fg colour232
set -g message-bg colour166

# }
```

### redessiner l'écran

Lorsque que l'on est à l'exterieur
```bash
tmux attach -d
```

### tmux pour administrer les serveurs

```bash
cat tmuxmoi.sh 
tmux new-session -d -s 'cassandra'  -n 'cassandra1' 'ssh root@10.0.145.201' 
tmux new-window -n 'cassandra2' 'ssh root@10.0.145.202'
tmux new-window -n 'cassandra3' 'ssh root@10.0.145.203'
tmux new-window -n 'kairos1' 'ssh root@10.0.145.204'

tmux -2 attach-session -d
```

executer-le

```bash
bash tmuxmoi.sh
```

#### se réattacher

```bash
tmux attach
```

### l'écran ne se "resize" pas

Sortir du tmux puis lister les clients avec tmux list-client

exemple
```bash
tmux list-client
/dev/pts/0: HYP [187x56 xterm-256color] (utf8) 
/dev/pts/158: SERVICES [90x21 xterm] (utf8) 
```

puis fermer les connexions clientes avec tmux detach-client

exemple

```bash
tmux detach-client -t /dev/pts/158
tmux detach-client -t /dev/pts/0
```
