#!/usr/bin/env bash

HERE=$(cd `dirname $0` && pwd)
source $HERE/print.sh
source $HERE/helpers.sh
source $HERE/link_files.sh

DOTFILES_PATH=$HERE

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
        running "Cleaning up linked files"
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

running "Updating submodules"
git submodule update --quiet --init --recursive
ok

echo;

bot "I'll start by checking out which shell you're using."

source_here="source $HERE/setup.sh"
set_dotpath="DOTFILES_PATH=$DOTFILES_PATH"

# If ZSH is used, auto source setup.sh in .zshrc
if [[ $SHELL == "/bin/zsh" ]]; then
    info "Using ZSH i see... Pretty neat dude!" 
    # sleep 1

    echo; 

    source powerlevel_installation.sh

    if [ -f $HOME/.zshrc ]; then
        bot "You already have a .zshrc file at home."
        if questionN "Do you want to override your existing configuration (will backup)"
        then
            filename="$HOME/.zshrc.$(date +%s).old"
            action "Backing up as $filename"
            mv $HOME/.zshrc $HOME/$filename

            if [ -d $HOME/.oh-my-zsh/custom/themes/powerlevel9k ]; then
                info "Using powerlevel configuration"
                mv $DOTFILES_PATH/other_files/zshrc-powerlevel $USER/.zshrc
            else
                info "Using standard configuration"
                mv $DOTFILES_PATH/other_files/zshrc $USER/.zshrc
            fi
        else
            bot "I feel sorry for you..."
        fi
    fi

    if ! grep -qF "$source_here" ~/.zshrc; then
        action "Adding automatic sourcing to $HOME/.zshrc"
        echo $set_dotpath >> $HOME/.zshrc
        echo $source_here >> $HOME/.zshrc
    fi

# If ZSH is not used, auto source setup.sh in .bashrc
else
    info "You are not using ZSH."

    if ! grep -qF "$source_here" ~/.bashrc; then
        action "Adding automatic sourcing to $HOME/.bashrc"
        echo $set_dotpath >> $HOME/.bashrc
        echo $source_here >> $HOME/.bashrc
    fi
fi

echo;

bot "I will now start configuring your system."
action "Linking files"
link