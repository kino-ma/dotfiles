#! /bin/sh
cp -r .zshrc .zsh .vimrc .vim ~/ \
    && cp -r nvim ~/.config/nvim \
    && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein_install.sh \
    && sh ./dein_install.sh ~/.vim/dein 1>/dev/null \
    && rm dein_install.sh \
