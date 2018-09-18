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
    local here=$(cd `dirname $0` && pwd)
    string="source $here/setup.sh"

    if [ -f $HOME/.zshrc ]; then
        grep -v "source $here/setup.sh" $HOME/.bashrc > $HOME/.bashrc
    fi

    if [ -f $HOME/.zshrc ]; then
        grep -v "source $here/setup.sh" $HOME/.zshrc > $HOME/.zshrc
    fi
}
