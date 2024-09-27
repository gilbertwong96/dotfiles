if status is-interactive
    # Commands to run in interactive sessions can go here
end

########################
### GLOBAL VARIABLES ###
########################

set LANG "en_US.UTF-8"
set LC_COLLATE "en_US.UTF-8"
set LC_CTYPE "en_US.UTF-8"
set LC_MESSAGES "en_US.UTF-8"
set LC_MONETARY "en_US.UTF-8"
set LC_NUMERIC "en_US.UTF-8"
set LC_TIME "en_US.UTF-8"
set LC_ALL "en_US.UTF-8"

#############
## OS Type ##
#############

switch (uname)
    case Linux
        set -gx OSTYPE "Linux"
    case Darwin
        set -gx OSTYPE "MacOS"
    case FreeBSD NetBSD DragonFly
        set -gx OSTYPE "FreeBSD"
    case '*'
        set -gx OSTYPE "unknown"
end

source ~/.asdf/asdf.fish
fish_add_path -agP $HOME/.cache/rebar3/bin $HOME/.cargo/bin $HOME/.vector/bin /opt/homebrew/opt/postgresql@16/bin

#######################################
## For Postgresql
#######################################

set -gx LDFLAGS "-L/opt/homebrew/opt/postgresql@16/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/postgresql@16/include"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/postgresql@16/lib/pkgconfig"

#######################################
## For Homebrew
#######################################

# set -xg MANPATH = /opt/homebrew/share/man:/usr/share/man:/usr/local/share/man:/usr/local/MacGPG2/share/man
if [ $OSTYPE = "MacOS" ]
    fish_add_path /opt/homebrew/bin /opt/homebrew/sbin $HOME/bin
    set -xg ERL_LIBS '/opt/homebrew/opt/proper/proper-1.4'

    ## For homebrew
    alias bubo 'brew update && brew outdated'
    alias bubc 'brew upgrade && brew cleanup'
    alias bubu 'bubo && bubc'

    fish_add_path -gP /opt/homebrew/opt/coreutils/libexec/gnubin \
        /opt/homebrew/opt/gnu-sed/libexec/gnubin
end

############
## Editor ##
############

## For emacs
# alias emacs 'TERM=xterm-emacs emacs -nw'
alias e 'emacsclient'
alias et 'emacsclient -t'
alias ec 'emacsclient -c'
alias en 'emacs -nw'
alias n 'nvim'

# set -xg TERM 'xterm-emacs'
set -xg EDITOR 'emacsclient'
set -xg GIT_EDITOR $EDITOR
set -xg SUDO_EDITOR 'emacsclient'

# Set network proxy
# set -xg https_proxy http://127.0.0.1:7890
# set -xg http_proxy http://127.0.0.1:7890
# set -xg all_proxy socks5://127.0.0.1:7890

##########
## Rust ##
##########
set -xg RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/library

###############
## Man Pager ##
###############

set -xg MANPAGER "col -bx | bat --theme Monokai\ Extended -l man -p"

####################
## Less Highlight ##
####################

set -gx LESS_TERMCAP_so \e'[00;43;34m'
set -gx LESS_TERMCAP_se \e'[0m'

# export LESS_TERMCAP_mb=$'\E[01;31m'
# export LESS_TERMCAP_md=$'\E[01;36m'
# export LESS_TERMCAP_me=$'\E[0m'
# export LESS_TERMCAP_se=$'\E[0m'
# export LESS_TERMCAP_so=$'\E[00;43;34m'
# export LESS_TERMCAP_ue=$'\E[0m'
# export LESS_TERMCAP_us=$'\E[01;32m'
# export GROFF_NO_SGR=1

####################
## Alias Commands ##
####################

## For Vector
# alias vector 'docker run -i -v (pwd)/:/etc/vector/ --rm timberio/vector:0.31.0-debian'

## For interesting tools
alias ping 'prettyping -nolegend'
alias preview="fzf --preview 'bat --color \"always\" {}'"

# Add support for ctrl+o to open selected file in emacs
set -xg FZF_DEFAULT_OPTS "--bind='ctrl-o:execute(emacsclient {})+abort'"
alias top btm
alias du 'ncdu --color dark -rr -x --exclude .git --exclude node_modules'
# alias help 'tldr'
alias cat 'bat --theme Monokai\ Extended -pp'
alias ls 'eza --icons'
alias ll 'ls -alhF'
alias lt 'll -T'
alias rm 'trash'

# ## For tmux
# alias tmux 'set TERM=xterm-256color tmux'

############
## Zoxide ##
############
zoxide init fish | source

#####################
## StarShip Prompt ##
#####################
starship init fish | source

set -xg TERM "screen-256color"

#####################
##     Dir ENV     ##
#####################
direnv hook fish | source

# Wrap tmux to avoid issues with environment loading.
# Make sure that direnv is unloaded before executing tmux, and avoid issues with environment variables mangling in tmux's subshells

alias tmux "direnv exec / tmux"

# pnpm
set -gx PNPM_HOME "/Users/gilbertwong/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
    eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
        . "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/homebrew/Caskroom/miniconda/base/bin" $PATH
    end
end

set -gx CONDA_AUTO_ACTIVATE_BASE false
# <<< conda initialize <<<
