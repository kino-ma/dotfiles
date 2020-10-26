#! /bin/sh

function update() {
    cp -r .zshrc .vimrc .zsh .vim ~/ \
        && cp -r nvim ~/.config/nvim
}


function install_tools() {
    if which apt 1>/dev/null
    then
        sudo apt update \
            && sudo apt install -y git curl vim neovim
    fi

    install_hub
    install_dein
    install_gfc
}

function isntall_hub() {
    if which apt 1>/dev/null
    then
        sudo apt update \
            && sudo apt install -y git curl vim neovim

        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0 \
            && sudo apt-add-repository https://cli.github.com/packages \
            && sudo apt update \
            && sudo apt install -y gh hub
    fi
}

function install_dein() {
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein_install.sh \
        && sh ./dein_install.sh ~/.vim/dein 1>/dev/null \
        && rm dein_install.sh
}

function install_gfc() {
    curl https://raw.githubusercontent.com/bobthecow/git-flow-completion/master/git-flow-completion.zsh > ~/.zsh/git-flow-completion.zsh
}



if [ $1 = "--update" ]
then
    echo "updating..."
    update
    echo "done"
elif [ -z $1 ]
then
    update
    install_tools
else
    echo "esage: $0 [FLAGS]"
    echo ""
    echo "    For default, setup whole enviroment."
    echo ""
    echo ""
    echo "FLAGS:"
    echo "    --update: Only update vimrc and zshrc, without"
    echo "              installing tools."
    echo ""
fi
