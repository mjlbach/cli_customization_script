update(){
    rustup update
    cargo +nightly install exa
    cargo +nightly install sd
    cargo +nightly install fd-find
    cargo +nightly install ripgrep
    cargo +nightly install bat
    cargo +nightly install ffsend

    source $HOME/.virtualenvs/neovim3/bin/activate
    pip install -U pip neovim-remote flake8 black

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
