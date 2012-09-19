################################################
# Exit if not running interactively            #
################################################
[ -z "$PS1" ] && return

################################################
# Setup $PATH                                  #
################################################
export PATH=/usr/local/bin:/usr/local/sbin:$PATH:$HOME/bin

################################################
# Aliases                                      #
################################################
alias ls='ls --color=auto'
alias la='ls -A'
alias ll="ls -lAthF"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias cd..='cd ..'
alias ...='cd ../..'
alias du="du -h"
alias df="df -h"
alias mkdir='mkdir -p'
alias vi='vim'

alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'


################################################
# Shell options                                #
################################################
# A command name that is the name of a directory is executed as if it
# were the argument to the cd command.
if [[ $BASH_VERSINFO -ge 4 ]]; then
    shopt -s autocd
fi

# Correct minor spelling errors in cd command.
shopt -s cdspell

# Check for stopped jobs and output a list when trying to exit bash
if [[ $BASH_VERSINFO -ge 4 ]]; then
    shopt -s checkjobs
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# ignore case when performing filename expansion
shopt -s nocaseglob

################################################
# Environment variables                        #
################################################
export EDITOR=vim
export VISUAL=vim
export LESSCHARSET="utf-8"

# Default
export PAGER="less -si"

# Colors to use in directory listings
export LS_COLORS='no=00:fi=00:di=36:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ex=01;32'

################################################
# History settings                             #
################################################
# don't put duplicate lines in the history. See bash(1) section 'HISTORY' for more options
export HISTCONTROL="ignoredups"

# ... and ignore same sucessive entries, as well as commands starting with a space.
export HISTCONTROL="ignoreboth"

# store more stuff in the history...
export HISTSIZE=10000
export HISTFILESIZE=10000

# puts full date and time in history records.
export HISTTIMEFORMAT="[%FT%T] "

# ignore relatively meaningless commands.
export HISTIGNORE="fg*:bg*:history*"

# make bash append to history rather than overwrite
shopt -s histappend

# store multiline commands as single entries in history file
shopt -s cmdhist

# allow re-editing of a history command substitution, if the previous run failed
shopt -s histreedit

################################################
# Command prompt settings                      #
################################################
export PS1="\[\e]2;\u@\H \w\a\e[32;1m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ "

# Tweaked prompt
if [ -f "$HOME/.bash_ps1" ]; then
    source "$HOME/.bash_ps1"
fi

################################################
# Functions                                    #
################################################

#===============================================
# Extract files from any archive               #
#===============================================
function extract (){
     if [ -f "$1" ] ; then
        case "$1" in
                *.tar.bz2) tar xjf $1 ;;
                *.tar.gz) tar xzf $1 ;;
                *.bz2) bunzip2 $1 ;;
                *.rar) rar x $1 ;;
                *.gz) gunzip $1 ;;
                *.tar) tar xf $1 ;;
                *.tbz2) tar xjf $1 ;;
                *.tgz) tar xzf $1 ;;
                *.zip) unzip $1 ;;
                *.Z) uncompress $1 ;;
                *.7z) 7z x $1 ;;
                *) echo "'$1' cannot be extracted via extract()" ;;
        esac
      else
        echo "'$1' is not a valid file"
      fi
}

#===============================================
# Change to directory and do ll                #
#===============================================
cdl() {
  if [ -n "$1" ]; then
    cd "$@" && ll
  else
    cd ~ && ll
  fi
}

################################################
# Windows settings                             #
################################################
if [ $OSTYPE == 'cygwin' ] ; then
    alias ll="ls -lAthFo"
fi

################################################
# OS X settings                                #
################################################
if [[ $OSTYPE == *darwin* ]]; then
    if [ -f "$HOME/.bash_ps1.osx" ]; then
        source "$HOME/.bash_ps1.osx"
    fi

    if [ -d "/usr/local/lib/python2.7/site-packages/" ]; then
        export PYTHONPATH=/usr/local/lib/python2.7/site-packages/
    fi
fi

################################################
# Host specific settings                       #
################################################
if [ -f "$HOME/.bash_host" ]; then
    source "$HOME/.bash_host"
fi
