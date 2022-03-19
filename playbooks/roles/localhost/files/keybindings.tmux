# guake-like windows management
bind-key -n C-PageUp previous-window
bind-key -n C-PageDown next-window
bind-key -n C-T new-window

# screen fix
unbind-key -n C-a

# alternative prefix for tmux-jump
unbind C-b
set-option -g prefix `
bind ` send-prefix
