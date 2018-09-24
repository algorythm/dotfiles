#!/usr/bin/env bash
function nfind()
{
    if [ ! "$(command -v nmap)" ]; then
        echo "nmap is not installed on your system."
        return;
    fi

    if [[ ! -n $2 ]]; then
        echo "You have to give a port, or a list of ports and an IP range."
        echo "Usage:"
        echo "   $0 ip/subnet [port]"
        echo;
        echo "Example: $0 192.168.0.0/24 22"
        return;
    fi

    range=$1
    shift
    ports=$@

    echo "Finding devices on subnet $range with ports $ports open to the public."
    hosts=nmap -n -Pn $range -p$ports -oG - | grep '/open/'
}

function reload()
{
    if [[ ! -n $1 ]]; then
        echo "Usage: $0 [bash|zsh]"
    fi

    source $HOME/.$1rc
}

# Finds the md5sum of a directory, usage: md5dir <folder>
function md5dir()
{
    if [ ! "$(command -v md5sum)" ]; then
        echo "md5sum is not installed on your system."
        return;
    fi

    find $1 -type f -exec md5sum {} \; | sort -k 2 | md5sum
}
