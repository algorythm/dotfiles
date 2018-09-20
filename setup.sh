#!/usr/bin/env bash

# if [[ ${SSH_TTY} ]]; then
#     source $HERE/files_to_source/bash_prompt.sh
# else
#     echo "You're not on a server"
# fi

if [[ $SHELL="/bin/bash" ]]; then
    source $DOTFILES_PATH/files_to_source/bash_prompt.sh
fi

# Set default text editor to vim
unamestr=$(uname)
if [[ $uname == "Linux" ]]; then
    update-alternatives --set editor /usr/bin/vim.basic
fi

source $DOTFILES_PATH/files_to_source/aliases.sh
source $DOTFILES_PATH/files_to_source/exports.sh
source $DOTFILES_PATH/files_to_source/functions.sh
