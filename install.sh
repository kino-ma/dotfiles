#! /usr/bin/env sh

update() {
    git pull \
        && cp .zshrc .vimrc .gitconfig .gitignore_global ~/ \
        && cp nvim/* $HOME/.config/nvim/ \
        && cp .zsh/* $HOME/.zsh/ \
        && cp .vim/* $HOME/.vim/ \
}

init_dirs() {
    mkdir $HOME/{.zsh,.vim,.config/nvim}
}


install_tools() {
    if which apt 1>/dev/null
    then
        sudo apt update \
            && sudo apt install -y git curl vim neovim
    fi

    install_hub
    install_dein
    install_gfc
}

isntall_hub() {
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

install_dein() {
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein_install.sh \
        && sh ./dein_install.sh ~/.vim/dein 1>/dev/null \
        && rm dein_install.sh
}

install_gfc() {
    curl https://raw.githubusercontent.com/bobthecow/git-flow-completion/master/git-flow-completion.zsh > ~/.zsh/git-flow-completion.zsh
}



if [ "$1" = "--update" ]
then
    echo "updating..."
    update
    echo "done"
elif [ -z "$1" ]
then
    echo "installing..."
    init_dirs
    update
    echo "cofiguring vimrc and zshrc has been done."
    echo "next, install other tools."
    echo ""
    install_tools
    echo ""
    echo "done"
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
