# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in *i*) ;;
     *) return;;
esac

# load .inputrc 
[ -f ~/.inputrc ] && bind -f ~/.inputrc

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# editor setting
export EDITOR=nvim
alias vim=nvim
alias vimdiff='nvim -d'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# PATH
[ -d ~/bin ] && export PATH=$PATH:~/bin
[ -d ~/lib ] && export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/lib

# trash-put
if [ -x /usr/bin/trash-put ]; then
  alias rm='echo "This is not the command you are looking for."; false'
fi
alias trash=trash-put

# acer fan control
alias fan-max='sudo /usr/local/bin/acer_ec.pl := "0x93" "0x14"; sudo /usr/local/bin/acer_ec.pl := "0x94" "0x00"'
alias fan-stop='sudo /usr/local/bin/acer_ec.pl := "0x93" "0x14"; sudo /usr/local/bin/acer_ec.pl := "0x94" "0xFF"'
alias fan-auto='sudo /usr/local/bin/acer_ec.pl := "0x93" "0x04"; sudo /usr/local/bin/acer_ec.pl := "0x94" "0xFF"'

# tmux & byobu
# Use nvim instead of vim.
# alias vim='TERM=xterm-256color vim'
# alias vi='TERM=xterm-256color vim'

# byobu
#[ -r /home/chicken/.byobu/prompt ] && . /home/chicken/.byobu/prompt   #byobu-prompt#

# python
# alias python="/usr/bin/python3"
# This make system confused because of changing version of the system python.
#
# pipenv can not install fipy. So we use pip instead of pipenv.
# We prefer to install packages in the system but user directory locally.
alias pip3-search='\pip3 search'
alias pip3='echo "Use with \"sudo -H\""; false'
# if [ -x /usr/bin/pipenv ]; then
#  alias pip3='echo "This is not the command you are looking for."; false'
# fi
# alias pip3="sudo -H /usr/bin/pip3"
# Using pipenv instead of pip3.
# python packages installed by pip should be set up on virtual environment.
# So, we use pipenv, a python virtual environment tool.
# Some packages used in system widely and offered by apt are installed on
# the system by using apt.

# less
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R '
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# man
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# alias commands
# clear backup files (*~)
alias trash-put_backup_files='find ~/ -name "Trash" -prune -o -type f -name "*~" -print -exec trash-put {} \;'
# Sync from OneDrive to Dropbox
alias OneDriveToDropbox='rsync -avh --delete ~/OneDrive/Documents ~/Dropbox'

# memo
# ln -s ~/Dropbox/Documents/config/ubuntu-disco_memo-setup.md ~/Notes/ubuntu-disco_memo-setup.md
# ln -s ~/Dropbox/Documents/config/ubuntu-disco_memo-usage.md ~/Notes/ubuntu-disco_memo-usage.md
alias memo-setup='nvim ~/Notes/ubuntu_memo-setup.md -c Toch'
alias memo-usage='nvim ~/Notes/ubuntu_memo-usage.md -c Toch'
alias win-memo-setup='nvim ~/Notes/windows10_memo-setup.md -c Toch'

# git
alias git-clone-min='git clone -b master --depth 1 --single-branch'

# imagej/fiji
alias imagej='~/opt/Fiji.app/ImageJ-linux64'

# tmux
# strange behavior
# alias tm='tmux attach || tmux new'
#
# If not running interactively, do not do anything
[[ $- != *i* ]] && return
# Otherwise start tmux
[[ -z "$TMUX" ]] && exec tmux 

# python - virtualenvwrapper
#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/Devel
#source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

# acer fan control
#alias fan-max='sudo /usr/local/bin/acer_ec.pl := "0x93" "0x14"; sudo /usr/local/bin/acer_ec.pl := "0x94" "0x00"'
#alias fan-stop='sudo /usr/local/bin/acer_ec.pl := "0x93" "0x14"; sudo /usr/local/bin/acer_ec.pl := "0x94" "0xFF"'
#alias fan-auto='sudo /usr/local/bin/acer_ec.pl := "0x93" "0x04"; sudo /usr/local/bin/acer_ec.pl := "0x94" "0xFF"'

# socat
#alias socat-pty='socat -d -d pty,raw,echo=0 pty,raw,echo=0'

# disable ctrl-s keystroke which stop the terminal output
stty stop undef

# Arduino-Makefile
#export export ARDUINO_DIR=/home/chicken/archive/arduino/arduino-nightly
#export ARDMK_DIR=/home/chicken/archive/arduino/Arduino-Makefile

# OpenFOAM
# source /opt/openfoam7/etc/bashrc
#alias openfoam6-linux='cd /home/chicken/OpenFOAM/chicken-6; openfoam6-linux'

# gmsh
#alias gmsh='/opt/gmsh-4.3.0-Linux64/bin/gmsh'

# FEnics
#alias fenicsproject='cd /home/chicken/fenics; /home/chicken/.local/bin/fenicsproject'

# golang
export GOPATH=~/go
export PATH=/usr/lib/go-1.13/bin:${PATH}:${GOPATH}/bin

# singularity
# . /usr/local/etc/bash_completion.d/singularity

# pdfjs
# function setup_pdfjs_server() {
#     cd ${HOME}/Workroom/pdfjs
#     python3 -m http.server 8887 &
#     export PDFJS_SERVER_STARTED = 1
# }
function pdfjs() {
    # [ ! -v ${PDFJS_SERVER_STARTED} ] && setup_pdfjs_server
    ln -f $1 ${HOME}/Workroom/pdfjs/web/tmp.pdf
    chromium http://localhost:8887/web/tmp_viewer.html &
}

# libmmg
# export LD_LIBRARY_PATH=${HOME}/Workroom/mmg/install/lib:${LD_LIBRARY_PATH}
# export MMG_INCLUDE_DIR=${HOME}/Workroom/mmg/install/include
# export MMG_LIBRARY=${HOME}/Workroom/mmg/install/lib
# export MMG_DIR=${HOME}/Workroom/mmg/install

