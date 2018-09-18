#!/usr/bin/env bash

HERE=$(cd `dirname $0` && pwd)
source $HERE/print.sh
source $HERE/helpers.sh

bot "This is the automated dotfiles setup. I'll get things configured for you mate."

echo;

bot "I'll start by checking out which shell you're using."

if [[ $SHELL="/bin/zsh" ]]; then
    info "Using ZSH i see... Pretty neat dude!" 
else
    info "Whoot! You're using $SHELL, omg! lol" 
fi

echo;

bot "I will now start configuring your system."
action "Linking files"
source link_files.sh

action "Adding automatic sourcing"
s="source $HERE/source_files.sh"
if ! grep -qF "$s" ~/.bashrc; then
    echo $s >> $HOME/.bashrc
fi