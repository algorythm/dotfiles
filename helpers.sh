#!/usr/bin/env bash
function confirm_sudo()
{
    if [[ ! $EUID -eq 0 ]]
    then
        echo "Please run as sudo.\n" >&2
        exit 1
    fi
}

function get_os()
{
    local uname=$(uname)
    echo $uname

    if [[ $uname == "Linux" ]]; then
        os=$(lsb_release -i -s)
    elif [[ $uname == "Darwin" ]]; then
        os=$uname
    else
        echo "Unidentified operating system: $uname"
        os=NULL
    fi

    return $os
}

function clean_rc_files()
{
    string="source $DOTFILES_PATH/setup.sh"

    if [ -f $HOME/.bashrc ]; then
        grep -v "DOTFILES_PATH=$DOTFILES_PATH" $HOME/.bashrc > bashrc && mv bashrc $HOME/.bashrc
        grep -v "source $DOTFILES_PATH/setup.sh" $HOME/.bashrc > bashrc && mv bashrc $HOME/.bashrc
    fi

    if [ -f $HOME/.zshrc ]; then
        grep -v "DOTFILES_PATH=$DOTFILES_PATH" $HOME/.zshrc > zshrc && mv zshrc $HOME/.zshrc
        grep -v "source $DOTFILES_PATH/setup.sh" $HOME/.zshrc > zshrc && mv zshrc $HOME/.zshrc
    fi
}
