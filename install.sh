#! /bin/sh
cp -r .zshrc .vimrc .vim ~/ \
    && cp -r nvim ~/.config/nvim \
    && mkdir ~/.zsh \
    && curl https://raw.githubusercontent.com/bobthecow/git-flow-completion/master/git-flow-completion.zsh > ~/.zsh/git-flow-completion.zsh \
    && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein_install.sh \
    && sh ./dein_install.sh ~/.vim/dein 1>/dev/null \
    && rm dein_install.sh \
