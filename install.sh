#! /bin/sh
cp -r .bashrc .zshrc .vim ~/

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.vim/dein
rm insttaller.sh
