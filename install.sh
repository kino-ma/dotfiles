#! /usr/bin/env bash

set -euxo pipefail

xbrew() {
    BREW_PREFIX=/usr/local arch -x86_64 /usr/local/Homebrew/bin/brew $*
}

update() {
    git pull >> /dev/null
    cp .zshrc .vimrc .gitconfig .gitignore_global ~/
    cp nvim/* $HOME/.config/nvim/
    cp .zsh/* $HOME/.zsh/
    cp .vim/rc/* $HOME/.vim/rc/
    cp .shell_fn/* $HOME/.shell_fn/
    ln -sf "$(readlink -f ./xdg/nix/nix.conf)" $HOME/.config/nix/nix.conf
}

echo_done() {
    set +x
    cat << 'EOS'

Instllation has been completed.'
You can re-login with `exec $SHELL -l`.'
EOS
    set -x
}

prompt_yes() {
    set +x
    echo -e -n "${1:-}"
    read 'answer'
    set -x
    [ "$answer" = 'y' ]
}

sureWantTo() {
    set +x
    prompt_text=$'Are you sure you want to install configuration files?(y/\e[04mn\e[00m): '

    if ! prompt_yes "$prompt_text"
    then
        set +x
        echo "stop."
        exit
    fi

    set -x
}

init_dirs() {
    mkdir -p $HOME/{.zsh/{,completion},.vim/{rc,tmp},.config/{nvim,nix},.shell_fn}
}


install_hub() {
    if [ "$(uname)" = "Linux" ] && which apt 1>/dev/null
    then
        sudo apt update
        sudo apt install -y git curl vim neovim

        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
        sudo apt-add-repository https://cli.github.com/packages
        sudo apt update
        sudo apt install -y gh hub
    elif [ "$(uname)" = "Darwin" ]
    then
        xbrew install hub
    fi
}

install_brew() {
    if [ "$(uname)" = "Darwin" ] && ! which brew >/dev/null
    then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        if [ "$(uname -m)" = "arm64" ];
        then
            # Install x86_64 version of brew
            arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi

    fi
}

install_gpg() {
    if [ "$(uname)" = "Darwin" ]
    then
        if [  "$(uname -m)" = "x86_64" ]
        then
            brew install gnupg pinentry-mac
        elif [ "$(uname -m)" = "arm64" ]
        then
            xbrew install gnupg pinentry-mac
        fi
    elif [ "$(uname)" = "Linux" ] && which apt &>/dev/null
    then
        sudo apt install gpg
    fi
}

configure_gpg() {
    mkdir -p ~/.gnupg
    chmod go-rwx ~/.gnupg

    # gpg -agent config
    (
    # enable ssh support
    echo "enable-ssh-support"
    # set pinentry program
    echo -n "pinentry-program "
    {
        which pinentry-mac 2>/dev/null || which pinentry; } | tail -n 1 | xargs readlink -f
    ) | tee ~/.gnupg/gpg-agent.conf

    install_gpg_key

    # use Authentication key for SSH
    gpg --list-key --with-keygrip | grep --after-context 1 --max-count 1 '\[A\]' | tail -n 1 | grep -Eo '[^ ]+$' | tee ~/.gnupg/sshcontrol

}

install_nvim() {
    if [ "$(uname)" = "Darwin" ]
    then
        if [  "$(uname -m)" = "x86_64" ]
        then
            brew install neovim
        elif [ "$(uname -m)" = "arm64" ]
        then
            xbrew install neovim
        fi
    elif [ "$(uname)" = "Linux" ] && which apt &>/dev/null
    then
        sudo add-apt-repository ppa:neovim-ppa/stable
        sudo apt-get update
        sudo apt-get install neovim
    fi
}

install_gitflow() {
    if [ "$(uname)" = "Linux" ] && which apt > /dev/null
    then
        sudo apt install git-flow
    elif [ "$(uname)" = "Darwin" -a "$(uname -m)" = "arm64" ]
    then
        xbrew install git-flow
    elif [ "$(uname)" = "Darwin" -a "$(uname -m)" = "x86_64" ]
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
        ln -sf $docker_etc/docker.zsh-completion /usr/local/share/zsh/site-functions/_docker
        ln -sf $docker_etc/docker-compose.zsh-completion /usr/local/share/zsh/site-functions/_docker-compose
    fi
}

install_iterm2_integrations() {
    curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash
}

install_gpg_key() {
    curl -L https://www.kino.ma/kino-ma.gpg | gpg --import -
    echo -e "5\ny\n" | gpg --command-fd 0 --expert --edit-key kino-ma trust
}

init() {
    install_completions
    install_iterm2_integrations
    configure_gpg
}

darwin_install() {
    if [ -z "${NIX_PROFILES-}" ]
    then
        set +eu
        sh <(curl -L https://nixos.org/nix/install)
        ( source /etc/bashrc || true )
        set -eu
    else
        echo "Nix already installed. Skipped"
    fi

    if ! which darwin-rebuild 2> /dev/null
    then
        (
        cd /tmp
        nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
        ./result/bin/darwin-installer
    )
    fi

    nix_darwin_dir="$HOME/.nixpkgs"
    cwd=$(pwd | xargs readlink -f)
    ln -fs "$cwd/system-config/darwin-configuration.nix" "$nix_darwin_dir/darwin-configuration.nix"

    local_config="$nix_darwin_dir/local-configuration.nix"
    if [ ! -f "$local_config" ]
    then
        cp "$cwd/system-config/darwin-local-configuration.nix" "$local_config"
    fi

    nix-channel --add "https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz" home-manager
    nix-channel --update
    darwin-rebuild switch

    configure_home_manager "${1:-darwin}"
}

nixos_install() {
    sudo nix-channel --add "https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz" home-manager
    sudo nix-channel --update

    configure_nixos_system
    configure_home_manager "${1:-}"
}

configure_nixos_system() {
    config="/etc/nixos/configuration.nix"
    config_bak="$config.dotfiles-bak"
    local_config="/etc/nixos/configuration.nix"

    if [ ! -f "$config_bak" ]
    then
        sudo cp "/etc/nixos/configuration.nix" "$config_bak"
    fi

    sudo cp "./system-config/nixos-configuration.nix" "$config"

    if [ ! -f "$config_bak" ]
    then
        sudo cp "/etc/nixos/configuration.nix" "$config_bak"
    fi
}

configure_home_manager() {
    home_manager_dir="$HOME/.config/nixpkgs"
    host_env=${1:-default}  # "desktop" or something
    cwd=$(pwd | xargs readlink -f)

    mkdir -p "$home_manager_dir"
    ln -fs "$cwd/nix/home.nix" "$home_manager_dir/home.nix"

    custom="$cwd/nix/$host_env.nix"
    if [ -f "$custom" ]
    then
        cp "$custom" "$home_manager_dir/custom.nix"
    fi

    if ! grep 'hm-session-vars.sh' "$HOME/.profile" >& /dev/null
    then
        echo '. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"' | tee -a "$HOME/.profile"
        . ~/.profile
    fi
}

run_update() {
    echo "updating..."
    init_dirs
    update
    set +x
    echo
    echo 'Initialization has been completed.'
    echo 'You can re-login with `exec $SHELL -l`.'
}

run_init() {
    echo "initializing..."
    init_dirs
    update
    init
    echo
    set +x
    echo 'Initialization has been completed.'
    echo 'You can re-login with `exec $SHELL -l`.'
}

run_usage() {
    set +x
    cat << EOS
usage: $0 [FLAGS]

    For default, setup whole enviroment.


FLAGS:
    --update: Only update vimrc and zshrc, without
              installing tools.
    --init:   Installs configs and some tools that
              are independent from platforms
EOS
}

run_install() {
    sureWantTo
    echo "installing..."

    init_dirs
    update
    set +x
    echo "cofiguring vimrc and zshrc has been done."
    echo "next, install system environment."
    echo ""
    set -x

    if [ "$(uname)" = "Darwin" ]
    then
        run_darwin
    elif [ "$(uname)" = "Linux" ]
    then
        run_linux
    fi

}

run_darwin() {
    echo "Installing for Darwin..."

    darwin_install "darwin"
    darwin-rebuild switch
    install_brew
    install_gitflow
    init

    echo_done
}

run_debian() {
    echo "Installing for Ubuntu/Debian..."
    sudo apt update
    install_gitflow
    install_gpg
    install_nvim

    init

    echo_done
}

run_nixos() {
    echo "Installing for NixOS..."

    host_env=""

    if [ "$OPTION" = "--desktop" ]
    then
        host_env="desktop"
    elif [ "$OPTION" = "--no-desktop" ]
    then
        host_env="default"
    else
        set +x
        while [ -z "$host_env" ]
        do
            cat << EOS

Please specify which environment are you setting up:
  1) Desktop
  2) Non-desktop
EOS
            echo -n "1/2?) "
            read env_choice
            if [ "$env_choice" = "1" ]
            then
                host_env="desktop"
            elif [ "$env_choice" = "2" ]
            then
                host_env="default"
            fi
        done
        set -x
    fi

    nixos_install "$host_env"
    init

    sudo nixos-rebuild switch

    echo_done
}

run_linux() {
    if [ -n "$(which apt 2>/dev/null)" ]
    then
        run_debian
    fi

    if [ -n "$(which nixos-version 2>/dev/null)" ]
    then
        run_nixos
    fi
}

export OPTION=${1:-}

if [ "$OPTION" = "--update" ]
then
    run_update $@
elif [ "$OPTION" = "--init" ]
then
    run_init $@
elif [ -z "$OPTION" ] || [ "$OPTION" = "--desktop" ] || [ "$OPTION" = "--no-desktop" ]
then
    run_install $@
else
    run_usage $@
fi
