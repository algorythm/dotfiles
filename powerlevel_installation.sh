#!/usr/bin/env bash
if [ -z {DOTFILES_PATH} ];
    source ./print.sh;
else
    source $DOTFILES_PATH/print.sh
fi

function install_powerlevel()
{
    if [[ ! $SHELL == "/bin/zsh" ]]; then
        if [[ "$(command -v zsh)" ]]; then
            error "ZSH is not installed on your system. Install it before running this script."
            return
        fi

        if questionY "Set default shell to ZSH"
        then
            chsh -s $(which zsh)
        fi
    fi

    if ! questionY "Do you want to install powerlevel"
    then
        return
    fi

    if questionY "Install powerline fonts"
    then
        $DOTFILES_PATH/PowerlineFonts/install.sh
    fi

    # Install oh-my-zsh if it isn't
    if [ ! -d $HOME/.oh-my-zsh ]; then
        if [[ "$(command -v curl)" ]]; then
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        elif [[ "$(command -v wget)" ]]; then
            sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
        else
            error "Install curl or wget before installing powerlevel"
        fi
    fi

    if [ ! -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]; then
        running "Cloning powerlevel to your .oh-my-zsh folder."
        git clone --quiet https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
        ok
    fi
    info "Installing auto suggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    info "Installing syntax highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

}

install_powerlevel
