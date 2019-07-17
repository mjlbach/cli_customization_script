install_vim(){
    git clone https://github.com/vim/vim.git
    cd vim
    ./configure --enable-python3interp --prefix=$HOME/local
    make -j
    make install
    cd ..
    rm -rf vim
    al
}

customize_vim(){
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    curl -fLo ~/.vimrc --create-dirs \
        https://raw.githubusercontent.com/mjlbach/vim_it_up/master/vimrc

    $HOME/local/bin/vim +PlugInstall +qall
    if [ `alias | vim | wc -l` = 0 ]; then
        echo "alias vim=$HOME/local/bin" >> $HOME/.bashrc
    fi
}

install_vim 
customize_vim
