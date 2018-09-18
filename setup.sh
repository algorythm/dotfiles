#!/usr/bin/env bash

HERE=$(cd `dirname $0` && pwd)
source $HERE/print.sh
source $HERE/helpers.sh

# if [[ ${SSH_TTY} ]]; then
#     source $HERE/files_to_source/bash_prompt.sh
# else
#     echo "You're not on a server"
# fi


if [[ $SHELL="/bin/bash" ]]; then
    source $HERE/files_to_source/bash_prompt.sh
fi

source $HERE/files_to_source/aliases.sh
source $HERE/files_to_source/functions.sh
