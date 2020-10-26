#! /bin/sh

if which apt 1>/dev/null
then
    sudo apt update \
        && sudo apt install -y git curl vim neovim

    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0 \
        && sudo apt-add-repository https://cli.github.com/packages \
        && sudo apt update \
        && sudo apt install -y gh
fi

cp -r .zshrc .vimrc .vim ~/ \
    && cp -r nvim ~/.config/nvim \
    && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein_install.sh \
    && sh ./dein_install.sh ~/.vim/dein 1>/dev/null \
    && rm dein_install.sh

mkdir ~/.zsh \
    && curl https://raw.githubusercontent.com/bobthecow/git-flow-completion/master/git-flow-completion.zsh > ~/.zsh/git-flow-completion.zsh
