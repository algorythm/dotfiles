#!/usr/bin/env bash

# if [[ ${SSH_TTY} ]]; then
#     source $HERE/files_to_source/bash_prompt.sh
# else
#     echo "You're not on a server"
# fi


if [[ $SHELL="/bin/bash" ]]; then
    source $DOTFILES_PATH/files_to_source/bash_prompt.sh
fi

source $DOTFILES_PATH/files_to_source/aliases.sh
source $DOTFILES_PATH/files_to_source/functions.sh
