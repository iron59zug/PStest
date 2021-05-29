#! /bin/bash

"""
system wide setting:
/etc/skel/.bashrc # default setting when creating new user
/etc/bash.bashrc # debian/ubuntu setting
/etc/bashrc # ???

individual user setting:
/root/.bashrc # root user
$HOME/.bashrc # debian/ubuntu user
"""

"""
# recommended to use additional .bash_aliases to store aliases
# and add its reference to ~/.bashrc OR $HOME/.bashrc:
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

# let the changes immediately take effect:
$ . ~/.bash_aliases
#OR this is the same as:
$ source ~/.bash_aliases
"""

# ~/.bash_aliases
alias ..='cd..'
alias aptu='apt update && apt upgrade'

alias la='ls -a'
alias las='ls -as'
alias llas='ls -als'
alias lls='ls -ls'
alias ll='ls -l'
alias ls='ls --color=auto'


alias p8='ping 8.8.8.8 -c 3'
alias pc3='ping -c 3'

alias rm='rm -i'
alias sc='systemctl'
