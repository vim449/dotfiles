# Load core POSIX
xsh load core -s posix

# Antigen module for zsh.
# https://github.com/zsh-users/antigen
#

# Path to the antigen installation.
ANTIGEN_PATH="${XDG_DATA_HOME:-$HOME/.local/share}/antigen/antigen.zsh"
ADOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/antigen"

# Install antigen if necessary.
if [[ ! -f $ANTIGEN_PATH ]]; then
  print -P "%F{33}:: Installing zsh-users/antigen...%f"
  command mkdir -p ${ANTIGEN_PATH:h}
  command curl -L 'git.io/antigen' >$ANTIGEN_PATH \
    && print -P "%F{34}:: Installation successful%f%b" \
    || { print -P "%F{160}:: Installation failed%f%b" && return 1 }
fi

# Source antigen.
source $ANTIGEN_PATH

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
    git
    archlinux
    github
    hlissner/zsh-autopair
    arzzen/calc.plugin.zsh
    IngoMeyer441/zsh-easy-motion
    hcgraf/zsh-sudo
    zsh-vi-more/vi-increment
    zsh-vi-more/vi-motions
    zsh-vi-more/vi-quote
    MichaelAquilina/zsh-you-should-use
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-completions
    softmoth/zsh-vim-mode
EOBUNDLES
antigen apply


# Setting fd as the default source for fzf
# Now fzf (w/o pipe) will use fd instead of find
export FZF_DEFAULT_COMMAND="fd --type f --ignore-file .gitignore --hidden"

alias doom-restart="killall emacs; doom sync; emacs --daemon"
alias ls='exa --sort .name --icons -G --git'

# Keybindings
bindkey -v
bindkey "^[ " autosuggest-accept
bindkey -M vicmd ' ' vi-easy-motion
# Vim keys in tab complete
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
autopair-init

# ZSH config
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
export FZF_COMPLETION_OPTS='--border --info=inline'

eval "$(starship init zsh)"
