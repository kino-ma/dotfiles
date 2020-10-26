#! /bin/sh
cp -r .zshrc .vimrc .vim ~/

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.vim/dein
rm insttaller.sh
