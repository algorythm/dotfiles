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
