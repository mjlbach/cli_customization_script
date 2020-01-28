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
install_apt_packages(){
    requirements=(ctags)
    sudo apt update
    for package in ${requirements[@]}; do
        dpkg -s "$package" >/dev/null 2>&1 && {
            echo "$package is installed."
        } || {
            sudo apt-get -y install $package
        }
    done
}


install_dependencies(){
    curl -fLo https://github.com/sharkdp/fd/releases/download/v7.4.0/fd_7.4.0_amd64.deb
    sudo dpkg -i fd_7.4.0_amd64.deb
    rm -rf fd_7.4.0_amd64.deb 
    curl -fLO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
    sudo dpkg -i ripgrep_11.0.2_amd64.deb
    rm -rf ripgrep_11.0.2_amd64.deb
    pip3 install --user -U pynvim flake8 black
}

install_configs(){
    curl -fLo ~/.tmux.conf \
    https://raw.githubusercontent.com/mjlbach/vim_it_up/master/configs/tmux/tmux.conf
    curl -fLo ~/.config/nvim/coc-settings.json \
    https://raw.githubusercontent.com/mjlbach/vim_it_up/master/configs/vim/coc-settings.json
    curl -fLo ~/.config/flake8 \
    https://raw.githubusercontent.com/mjlbach/vim_it_up/master/configs/vim/flake8
}

install_node(){
    if ! [ -x "$(command -v node)" ]; then
      curl -L https://git.io/n-install | bash
      source $HOME/.profile
      source $HOME/.bashrc
      curl -o- -L https://yarnpkg.com/install.sh | bash
      source $HOME/.profile
      source $HOME/.bashrc
    fi
}
install_neovim(){
    if [ "$(uname)" == "Darwin" ]
    then 
        brew install neovim --HEAD
        echo "MacOS"
    elif [ "$(uname)" == "Linux" ]
    then
        curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --create-dir -o $HOME/.neovim/nvim.appimage
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
    https://raw.githubusercontent.com/mjlbach/vim_it_up/master/configs/vim/init.vim

    $HOME/.neovim/nvim.appimage +PlugInstall +qall 
}

backup_configurations
install_apt_packages
install_node
install_dependencies
install_configs
install_neovim
