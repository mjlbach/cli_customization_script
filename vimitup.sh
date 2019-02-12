#! /usr/bin/env/bash

backup_configurations(){
    if [ -f $HOME/.config/nvim/init.vim ]; then
        echo "Pre-existing neovim configuration found"
        cp $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim.bak
    fi 
    if [ -f $HOME/.tmux.conf ]; then
        echo "Pre-existing tmux configuration found"
        cp $HOME/.tmux.conf $HOME/.tmux.conf.bak
    fi 
}

restore_backup(){
    if [ -f $HOME/.config/nvim/init.vim.bak ]; then
        echo "Pre-existing neovim configuration found"
        cp $HOME/.config/nvim/init.vim.bak $HOME/.config/nvim/init.vim
    else
        echo "Error, no neovim backup detected!"
    fi 
    if [ -f $HOME/.tmux.conf ]; then
        echo "Pre-existing tmux configuration found"
        cp $HOME/.tmux.conf.bak $HOME/.tmux.conf
    else
        echo "Error, no tmux backup detected!"
    fi 
}

install_apt_packages(){
    requirements=(curl tmux python2.7 python-pip virtualenv python3-venv ctags)
    sudo apt update
    for package in ${requirements[@]}; do
        dpkg -s "$package" >/dev/null 2>&1 && {
            echo "$package is installed."
        } || {
            sudo apt-get -y install $package
        }
    done
}

make_virtual_envs(){
    if [ ! -f $HOME/.virtualenvs/neovim2/bin/activate ]; then 
        virtualenv $HOME/.virtualenvs/neovim2
        source $HOME/.virtualenvs/neovim2/bin/activate
        pip2 install -U pynvim
        deactivate 
    fi

    if [ ! -f $HOME/.virtualenvs/neovim3/bin/activate  ]; then 
        python3 -m venv $HOME/.virtualenvs/neovim3
        source $HOME/.virtualenvs/neovim3/bin/activate
        pip install -U pynvim
        deactivate
    fi
}

install_rust_dependencies(){
    if ! [ -x "$(command -v cargo)" ]; then
      echo "Error: Rust is not installed. Let's fix that" >&2
      curl https://sh.rustup.rs -sSf | sh
      source $HOME/.profile
      source $HOME/.bashrc
    else
        echo "You're good to go!"
    fi
    cargo install ripgrep
    cargo install bat
    cargo install fd-find
    cargo install exa
}

customize_tmux(){
    curl -fLo ~/.tmux.conf \
    https://raw.githubusercontent.com/mjlbach/vim_it_up/master/.tmux.conf
}

install_neovim(){
    if [ "$(uname)" == "Darwin" ]
    then 
        brew install neovim
        echo "MacOS"
    elif [ "$(uname)" == "Linux" ]
    then
        curl -L https://github.com/neovim/neovim/releases/download/v0.3.4/nvim.appimage --create-dir -o $HOME/.neovim/nvim.appimage
        chmod u+x $HOME/.neovim/nvim.appimage
        if [ `alias | grep nvim | wc -l` != 0 ]; then
            echo "Warning, nvim alias already detected. Ensure your alias points to ~/.neovim/nvim.appimage in your bashrc"
        elif [ `alias | grep nvim | wc -l` = 0 ]; then
            echo "alias nvim=$HOME/.neovim/nvim.appimage" >> $HOME/.bashrc
        fi
    else 
        echo "Get a better OS!"
    fi

    mkdir -p $HOME/.vim/{swap,backup,undo}

    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    curl -fLo ~/.config/nvim/init.vim --create-dirs \
    https://raw.githubusercontent.com/mjlbach/vim_it_up/master/init.vim

    $HOME/.neovim/nvim.appimage +PlugInstall +qall 
}

uninstall_neovim(){
    if [ "$(uname)" == "Darwin" ]
    then 
        brew uninstall neovim
    elif [ "$(uname)" == "Linux" ]
    then
        rm -rf $HOME/.local/share/nvim
        rm $HOME/.neovim/nvim.appimage
        rm $HOME/.config/nvim/init.vim
        rm $HOME/.tmux.conf
    else 
        echo "Please visit https://www.getgnulinux.org/en/ for more information on switching to a friendlier operating system"
    fi
}

backup_configurations
install_apt_packages
make_virtual_envs
customize_tmux
install_rust_dependencies
install_neovim
