#! /usr/bin/env/bash

backup_configurations(){
    if [ -f $HOME/.config/nvim/init.vim ]; then
        echo "Pre-existing neovim configuration found"
        cp $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim.bak
    else
        echo "You are clear to go"
    fi
}

check_if_installed(){
    if ! [ -x "$(command -v cargo)" ]; then
      echo 'Error: Rust is not installed.' >&2
    else
        echo "You're good to go!"
    fi
}

install_rg(){
    if ! [ -x "$(command -v cargo)" ]; then
      echo 'Error: Rust is not installed.' >&2
      curl https://sh.rustup.rs -sSf | sh
      source $HOME/.bash_profile
      source $HOME/.bashrc
    else
        echo "You're good to go!"
    fi
    cargo install ripgrep
}

install_neovim(){
    if [ "$(uname)" == "Darwin" ]
    then 
        brew install neovim
        echo "MacOS"
    elif [ "$(uname)" == "Linux" ]
    then
        curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --create-dir -o $HOME/.neovim/nvim.appimage
        chmod u+x $HOME/.neovim/nvim.appimage
        echo "alias nvim=$HOME/.neovim/nvim.appimage" >> $HOME/.bashrc
    else 
        echo "Get a better OS!"
    fi

    mkdir -p $HOME/.vim/{swap, backup, undo}

    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    nvim +PlugInstall +qall 
}

uninstall_neovim(){
    if [ "$(uname)" == "Darwin" ]
    then 
        brew uninstall neovim
    elif [ "$(uname)" == "Linux" ]
    then
        rm -rf $HOME/.neovim/nvim.appimage
    else 
        echo "Get a better OS!"
    fi

    rm -rf $HOME/.local/share/nvim
}

check_if_installed
