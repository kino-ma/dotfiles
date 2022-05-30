#! /usr/bin/env bash

set -euxo pipefail

update() {
    git pull >> /dev/null \
        && cp .zshrc .vimrc .gitconfig .gitignore_global ~/ \
        && cp nvim/* $HOME/.config/nvim/ \
        && cp .zsh/* $HOME/.zsh/ \
        && cp .vim/rc/* $HOME/.vim/rc/ \
        && cp .shell_fn/* $HOME/.shell_fn/ \

}

sureWantTo() {
    set +x
    echo -e -n $'Are you sure you want to install configuration files?(y/\e[04mn\e[00m): '
    read answer
    if [ "$answer" != "y" ]
    then
        echo "stop."
        exit
    fi
    set -x
}

init_dirs() {
    mkdir -p $HOME/{.zsh/{,completion},.vim/{rc,tmp},.config/nvim,.shell_fn}
}


install_hub() {
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
        && sh ./dein_install.sh "$HOME/.vim/dein" 1>/dev/null \
        && rm dein_install.sh
}

install_gitflow() {
    if [ "$(uname)" = "Linux" ] && which apt > /dev/null
    then
        sudo apt install git-flow
    elif [ "$(uname)" = "Darwin" ]
    then
        brew install git-flow
    else
        echo 'unknown system. skip git-flow'
        return
    fi
}

chsh_zsh() {
    if which zsh &> /dev/null
    then
        chsh -s $(which zsh)
    else
        echo 'zsh not found. skipping.'
    fi
}

install_completions() {
    local completion_root
    completion_root="$HOME/.zsh/completion"

    # Git Flow
    curl \
        -L https://raw.githubusercontent.com/bobthecow/git-flow-completion/master/git-flow-completion.zsh \
        -o "$completion_root/git-flow-completion.zsh"
    # Docker Compose
    curl \
        -L https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/zsh/_docker-compose \
        -o "$completion_root/_docker-compose"

    # On mac OS, create symbolic link to completion the script pre-installed by Docker Desktop
    if [[ "$(uname)" == "Darwin" ]]
    then
        docker_etc=/Applications/Docker.app/Contents/Resources/etc
        ln -s $docker_etc/docker.zsh-completion /usr/local/share/zsh/site-functions/_docker
        ln -s $docker_etc/docker-compose.zsh-completion /usr/local/share/zsh/site-functions/_docker-compose
    fi
}

install_iterm2_integrations() {
    curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash
}

install_tools() {
    if which apt 1>/dev/null
    then
        sudo apt update \
            && sudo apt install -y zsh git curl vim neovim
    fi

    install_dein
    install_gitflow
    install_completions
    install_iterm2_integrations
    install_hub
}

OPTION=${1:-}

if [ "$OPTION" = "--update" ]
then
    echo "updating..."
    init_dirs
    update
    echo
    echo 'Initialization has been completed.'
    echo 'You can re-login with `exec $SHELL -l`.'
elif [ "$OPTION" = "--init" ]
then
    echo "initializing..."
    init_dirs
    update
    install_dein
    install_completions
    install_iterm2_integrations
    echo
    echo 'Initialization has been completed.'
    echo 'You can re-login with `exec $SHELL -l`.'
elif [ -z "$OPTION" ]
then
    sureWantTo
    echo "installing..."
    init_dirs
    update
    echo "cofiguring vimrc and zshrc has been done."
    echo "next, install other tools."
    echo ""
    install_tools
    chsh_zsh
    echo ""
    echo 'Instllation has been completed.'
    echo 'You can re-login with `exec $SHELL -l`.'
else
    echo "usage: $0 [FLAGS]"
    echo ""
    echo "    For default, setup whole enviroment."
    echo ""
    echo ""
    echo "FLAGS:"
    echo "    --update: Only update vimrc and zshrc, without"
    echo "              installing tools."
    echo "    --init:   Installs configs and some tools that"
    echo "              are independent from platforms"
fi
