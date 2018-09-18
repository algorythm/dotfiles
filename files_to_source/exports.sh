#!/usr/bin/env bash

# If Android Studio is installed, and OS is Mac, export sdk to PATH
unamestr=`uname`
if [[ $unamestr == "Darwin" ]]; then
    ah="/Users/$USER/Library/Android/sdk"
    if [ -d $ah ]; then
        export ANDROID_HOME=/Users/$USER/Library/Android/sdk
        export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
    fi
fi

# export PATH=${PATH}:~/dotfiles/bin
