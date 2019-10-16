update(){
    rustup update
    cargo +nightly install exa -Z install-upgrade
    cargo +nightly install sd -Z install-upgrade
    cargo +nightly install fd-find -Z install-upgrade
    cargo +nightly install ripgrep -Z install-upgrade
    cargo +nightly install bat -Z install-upgrade

    source $HOME/.virtualenvs/neovim3/bin/activate
    pip install -U pip
    pip install -U pynvim

    source $HOME/.virtualenvs/neovim2/bin/activate
    pip install -U pip
    pip install -U pynvim

    curl -fLo ~/.tmux.conf \
    https://raw.githubusercontent.com/mjlbach/vim_it_up/master/configs/tmux/tmux.conf

    curl -fLo ~/.config/nvim/init.vim --create-dirs \
    https://raw.githubusercontent.com/mjlbach/vim_it_up/master/configs/vim/init.vim

    curl -fLo ~/.config/nvim/coc-settings.json \
    https://raw.githubusercontent.com/mjlbach/vim_it_up/master/configs/vim/coc-settings.json

    curl -fLo ~/.config/flake8 \
    https://raw.githubusercontent.com/mjlbach/vim_it_up/master/configs/vim/flake8
    
    curl -fLo $HOME/.neovim/nvim.appimage \
    https://github.com/neovim/neovim/releases/download/v0.4.2/nvim.appimage

    chmod +x $HOME/.neovim/nvim.appimage
    
    $HOME/.neovim/nvim.appimage +PlugInstall +qall 
}

update
