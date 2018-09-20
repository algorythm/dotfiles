#!/usr/bin/env bash

if [ -x "$(command -v zsh)" ]; then
    echo "ZSH is already installed..." >&2
    exit 1
fi

echo "Installing ZSH..."

[[ -x "$(command -v brew)" ]] && brew install zsh
[[ -x "$(command -v apt-get)" ]] && sudo apt-get install -y zsh

sudo -s 'echo $(which zsh) >> /etc/shells' && chsh -s $(which zsh)

echo "Installing oh-my-zsh..."

[[ -x "$(command -v curl)" ]] && sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
[[ -x "$(command -v wget)" ]] && sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo "Done!"
