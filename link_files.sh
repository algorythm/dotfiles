#!/bin/usr/env bash
HERE=$(cd `dirname $0` && pwd)
files=$(ls $HERE/files_to_link)

source $HERE/print.sh

function link()
{
    # Go to the dotfiles directory
    cd $HERE/files_to_link

    for file in *; do
        if [ -f ~/.$file ]; then
            warning "\"$file\" already exist in your home directory."
        else
            ln -s $HERE/files_to_link/$file $HOME/.$file
        fi
    done

    # Go back to previous directory
    cd - > /dev/null 2>&1
}

function clean_link_files()
{
    running "Cleaning all linked files"

    # Go to the dotfiles directory
    cd $HERE/files_to_link

    for file in *; do
        if [ -L ~/.$file ]; then
            rm $HOME/$file
        fi
    done

    # Go back to previous directory
    cd - > /dev/null 2>&1

    ok
}
