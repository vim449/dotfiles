# Fetch current tty
[ ! "$TTY" ] && TTY="$(tty)"

# Disable control flow (^S/^Q).
[ -r "${TTY:-}" ] && [ -w "${TTY:-}" ] && command -v stty >/dev/null \
  && stty -ixon <"$TTY" >"$TTY" || true

# General settings
HISTFILE=$HOME/.local/share/shell/history
set -o noclobber # Apparently this is a better option
set -o notify    # Tell me about my running jobs
test -d  /nix/ && source /etc/profile.d/nix.sh

# Basics
alias reload='exec "$XSHELL"' # Should be self-explanatory
alias sudo='sudo ' # Let me use my aliases in sudo
alias su='su -l' # When I switch users, log in
alias cls='clear'
alias q='exit'
alias path='echo $PATH | sed "s/:/\n/g" | grep -v antigen'

# Human readable output
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias df='df -h' du='du -h'

# Directory management
alias ls='exa --sort .name --icons -G --git' # Use exa as an ls replacement
alias lsa='ls -aa' # List dotfiles
alias l='ls -lah' # List files in human readable long format
alias ll='ls -lh' # standard files in long list mode
alias la='ls -laah' # Show . and ..
alias lr='l -R' # Recursively list files
alias lx='l -XB'
alias lk='l -Sr'
alias lt='l -tr'
alias ltc='lt -c'
alias lta='lt -u'

# Tree listing
alias tl='tree --dirsfirst --filelimit=50'
alias tla='tl -a -I .git'

# Making directories
alias md='mkdir -p'
alias mkd='mkdir'
alias rd='rmdir'

# SystemD convenience
alias sc='systemctl'
alias scu='sc --user'
alias jc='journalctl --catalog'
alias jcb='jc --boot=0'
alias jcf='jc --follow'
alias jce='jc -b0 -p err..alert'

# Simple progress bar output for downloaders by default.
alias curl='curl --progress-bar'
alias wget="wget -q --show-progress -hsts-file='$XDG_CACHE_HOME/wget-hsts'"

# Better command replacements
alias cat="bat"
alias du="dust"
alias grep="rg"
alias btm="btm --color gruvbox"
alias top="btm -b"
alias vim='nvim'
alias vifm='sh $HOME/.config/vifm/scripts/vifmrun'
