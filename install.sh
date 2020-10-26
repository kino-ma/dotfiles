#! /bin/sh
cp -r .zshrc .vimrc .vim ~/ \
    && cp -r nvim ~/.config/nvim \
    && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein_install.sh \
    && sh ./dein_install.sh ~/.vim/dein \
    && rm dein_install.sh \
