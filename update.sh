update(){
    rustup update
    cargo install --force exa 
    cargo install --force fd-find
    cargo install --force ripgrep 
    cargo install --force bat

    source $HOME/.virtualenvs/neovim3/bin/activate
    pip install -U pip
    pip install -U pynvim

    source $HOME/.virtualenvs/neovim2/bin/activate
    pip install -U pip
    pip install -U pynvim

    curl -fLo ~/.tmux.conf \
    https://raw.githubusercontent.com/mjlbach/vim_it_up/master/.tmux.conf

    curl -fLo ~/.config/nvim/init.vim --create-dirs \
    https://raw.githubusercontent.com/mjlbach/vim_it_up/master/init.vim

    curl -fLo ~/.config/nvim/coc-settings.json \
    https://raw.githubusercontent.com/mjlbach/vim_it_up/master/coc-settings.json

    curl -fLo ~/.config/flake8 \
    https://raw.githubusercontent.com/mjlbach/vim_it_up/master/flake8.conf

    $HOME/.neovim/nvim.appimage +PlugInstall +qall 
}

update
