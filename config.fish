if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx LIBRARY_PATH /opt/homebrew/opt/libgccjit/lib/gcc/current

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

#######################################
## Add asdf shims to path
#######################################

if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end

set --erase _asdf_shims

set GEM_HOME (ruby -e "print Gem.user_dir")

fish_add_path -agP \
    # Local bin
    $HOME/.local/bin \
    # Deno bin
    $HOME/.deno/bin \
    # For Erlang rebar3
    $HOME/.cache/rebar3/bin \
    # For Rust Cargo
    $HOME/.cargo/bin \
    # For vector
    $HOME/.vector/bin \
    # For Postgresql
    /opt/homebrew/opt/postgresql@16/bin \
    # For golang
    $HOME/go/bin \
    # For ruby gem
    $GEM_HOME/bin

#######################################
## For Postgresql
#######################################

set -gx LDFLAGS "-L/opt/homebrew/opt/postgresql@16/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/postgresql@16/include"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/postgresql@16/lib/pkgconfig"

#######################################
## For Compilers to find openjdk
#######################################

set -gx CPPFLAGS "$CPPFLAGS -I/opt/homebrew/opt/openjdk/include"

# For the system java swrapper on MacOS to find this JDK, symlink it with
# sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

#######################################
## For Homebrew
#######################################

# set -xg MANPATH = /opt/homebrew/share/man:/usr/share/man:/usr/local/share/man:/usr/local/MacGPG2/share/man
if [ $OSTYPE = "MacOS" ]
    fish_add_path -agP /opt/homebrew/bin /opt/homebrew/sbin /opt/homebrew/opt/openjdk/bin $HOME/bin
    set -xg ERL_LIBS '/opt/homebrew/opt/proper/proper-1.4'

    ## For homebrew
    alias bubo 'brew update && brew outdated'
    alias bubc 'brew upgrade && brew cleanup'
    abbr -a bubu 'bubo && bubc'

    fish_add_path -gP /opt/homebrew/opt/coreutils/libexec/gnubin \
        /opt/homebrew/opt/gnu-sed/libexec/gnubin

    source ~/.orbstack/shell/init.fish 2>/dev/null || :
end

############
## Editor ##
############

## For emacs
# alias emacs 'TERM=xterm-emacs emacs -nw'
abbr -a e 'emacsclient'
abbr -a et 'emacsclient -t'
abbr -a ec 'emacsclient -c'
abbr -a en 'emacs -nw'
abbr -a n 'nvim'

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
abbr -a ping 'prettyping -nolegend'
abbr -a preview "fzf --preview 'bat --color \"always\" {}'"

# Add support for ctrl+o to open selected file in emacs
set -xg FZF_DEFAULT_OPTS "--bind='ctrl-o:execute(emacsclient {})+abort'"
abbr -a top btm
abbr -a du 'ncdu --color dark -rr -x --exclude .git --exclude node_modules'
# abbr -a help 'tldr'
abbr -a cat 'bat --theme Monokai\ Extended -pp'
alias ls 'eza --icons'
abbr -a ll 'ls -alhF'
abbr -a lt 'll -T'
abbr -a rm 'trash'

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

abbr -a tmux "direnv exec / tmux"

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/gilbertwong/miniconda3/bin/conda
    eval /Users/gilbertwong/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/Users/gilbertwong/miniconda3/etc/fish/conf.d/conda.fish"
        . "/Users/gilbertwong/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/Users/gilbertwong/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.

# Enhance git command
abbr -a g   'git'
abbr -a ga  'git add'
abbr -a gaa 'git add all'

abbr -a gb    'git branch -vv'
abbr -a gbD   'git branch -D'
abbr -a gba   'git branch -a -v'
abbr -a gban  'git branch -a -v --no-merged'
abbr -a gbd   'git branch -d'
abbr -a gbl   'git branch -b -w'
abbr -a gbs   'git bisect'
abbr -a gbsb  'git bisect bad'
abbr -a gbsg  'git bisect good'
abbr -a gbsr  'git bisect reset'
abbr -a gbss  'git bisect start'
abbr -a gc    'git commit -v'
abbr -a gca   'git commit -v -a'
abbr -a gca!  'git commit -v -a --amend'
abbr -a gcam  'git commit -a -m'
abbr -a gcan! 'git commit -v -a --no-edit --amend'
abbr -a gcav  'git commit -a -v --no-verify'
abbr -a gco   'git checkout'
abbr -a gca   'git commit -v -a'
abbr -a gcl   'git clone'
abbr -a gcl   'git clone'
abbr -a gcf   'git config list'
abbr -a gclean 'git clean -di'
abbr -a gclean! 'git clean -dfx'
