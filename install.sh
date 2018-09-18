#!/usr/bin/env bash

HERE=$(cd `dirname $0` && pwd)
source $HERE/print.sh
source $HERE/helpers.sh
source $HERE/link_files.sh

# Passing arguments
POSITIONAL=()
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -c|--clean|--remove)
        bot "Cleaning up dotfiles."
        running "Removing sourcing from rc files"
        clean_rc_files
        ok
        rimmomg "Cleaning up linked files"
        clean_link_files
        ok
        bot "Finished! You need to manually restore the .zshrc file if that is wanted."
        exit 0
        shift
        ;;
    esac
done

# Restore positional parameters
set -- "${POSITIONAL[@]}" 


bot "This is the automated dotfiles setup. I'll get things configured for you mate."

echo;

bot "I'll start by checking out which shell you're using."

# If ZSH is used, auto source setup.sh in .zshrc
if [[ $SHELL="/bin/zsh" ]]; then
    info "Using ZSH i see... Pretty neat dude!" 
    # sleep 1

    echo; 

    if [ -f $HOME/.zshrc ]; then
        bot "You already have a .zshrc file at home."
        if questionN "Do you want to override your existing configuration (will backup)"
        then
            filename="$HOME/.zshrc.$(date +%s).old"
            action "Backing up as $filename"
            mv $HOME/.zshrc $HOME/$filename
        else
            bot "I feel sorry for you..."
        fi
    fi

    s="source $HERE/setup.sh"

    if ! grep -qF "$s" ~/.zshrc; then
        action "Adding automatic sourcing to $HOME/.zshrc"
        echo $s >> $HOME/.zshrc
    fi
# If ZSH is not used, auto source setup.sh in .bashrc
else
    info "You are not using ZSH."
    s="source $HERE/setup.sh"

    if ! grep -qF "$s" ~/.bashrc; then
        action "Adding automatic sourcing to $HOME/.bashrc"
        echo $s >> $HOME/.bashrc
    fi
fi

echo;

bot "I will now start configuring your system."
action "Linking files"
link