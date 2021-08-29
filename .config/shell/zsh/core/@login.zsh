#!/bin/zsh

# XDG Base Dir
# I set these explicitly so I can assume them later on
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_LIB_HOME="$HOME/.local/lib"

# XDG for ZSH
export ZDATADIR=${ZDATADIR:-$XDG_DATA_HOME/zsh}
export ZCACHEDIR=${ZCACHEDIR:-$XDG_CACHE_HOME/zsh}
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}
command mkdir -p $ZDATADIR $ZCACHEDIR

# XDG Library spec for package managers
export STACK_ROOT="$XDG_LIB_HOME/stack"
export GRADLE_USER_HOME="$XDG_LIB_HOME/gradle"

#XDG Config overrides
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-#$HOME/.config}/npm/npmrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"
export ANDROID_PREFS_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export ADB_KEYS_PATH="$ANDROID_PREFS_ROOT"
export ANDROID_EMULATOR_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/android/emulator"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME:-$HOME/.config}/java"
export TEXMFVAR="${XDG_CACHE_HOME:-$HOME/.cache}/texlive/texmf-var"
export TEXMFCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/texlive/texmf-config"
export PYTHONSTARTUP="${XDG_CONFIG_HOME:-$HOME/.config}/python/startup"

# XDG Data override
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export TEXMFHOME="${XDG_DATA_HOME:-$HOME/.local/share}/texmf"
export GNUPGHOME="${XDG_DATE_HOME:-$HOME/.local/share}/gnupg"

# Cache overrides
export PYLINTHOME="${XDG_CACHE_HOME:-$HOME/.cache}/pylint"
export USERXSESSION="${XDG_CACHE_HOME:-$HOME/.cache}/x11/xsession"
export USERXSESSIONRC="${XDG_CACHE_HOME:-$HOME/.cache}/x11/xsessionrc"
export ALTUSERXSESSION="${XDG_CACHE_HOME:-$HOME/.cache}/x11/Xsession"
export ERRFILE="${XDG_CACHE_HOME:-$HOME/.cache}/x11/xsession-errors"

# XDG path to the X server auth cookie. This must match the display manager setting.
# It should be located in XDG_RUNTIME_DIR but sddm does not allow that.
[[ -f "$XDG_CACHE_HOME/Xauthority" ]] \
  && export XAUTHORITY="$XDG_CACHE_HOME/Xauthority"

# Adds XDG_BIN_DIR recursively to $PATH
PATH="$(/bin/du "$XDG_BIN_HOME" | cut -f2 | paste -sd ':' -)"
PATH+=":/usr/local/bin:/sbin:/usr/sbin:$HOME/.config/emacs/bin/:$HOME/.cabal/bin"

if (( $+commands[go] )); then
    # Add installed go binaries to PATH.
    export GOPATH="$XDG_LIB_HOME/go"
    path+=($GOPATH/bin)
    # Use the module-aware mode by default.
    export GO111MODULE='on'
fi

if (( $+commands[python] )); then
	# Add installed python package to PATH
    export PYTHON_HOME="$XDG_LIB_HOME/python"
	path+=($PYTHON_HOME/bin)
fi

if (( $+commands[npm] )); then
    # Add installed node binaries to PATH.
    export NPM_CONFIG_PREFIX="$XDG_LIB_HOME/npm"
    path+=($XDG_LIB_HOME/npm/bin)
fi

if (( $+commands[cargo] )); then
    # Add installed rust binaries to PATH
    export CARGO_HOME="$XDG_LIB_HOME/cargo"
    path+=($XDG_LIB_HOME/cargo/bin/)
fi

# Other program settings:
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
export QT_QPA_PLATFORMTHEME="gtk2"	# Have QT use gtk2 theme.
export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.

export GTK_IM_MODULE='fcitx'
export QT_IM_MODUle='fcitx'
export SDL_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'

HISTSIZE=10000000
SAVEHIST=10000000

# Autostart X if on tty1 and not already running
if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep xmonad || startx /home/dominic/.config/x11/xinitrc
fi
