sudo apt install zsh direnv lua5.2

mkdir -p $HOME/.config/shell

if [ ! -d $HOME/.config/shell/powerlevel10k ]
then
    git clone https://github.com/romkatv/powerlevel10k.git $HOME/.config/shell/powerlevel10k
fi

if [ ! -d $HOME/.config/shell/z.lua ]
then
    git clone https://github.com/skywind3000/z.lua.git $HOME/.config/shell/z.lua
fi

curl -fLo ~/.zshrc \
    https://raw.githubusercontent.com/mjlbach/vim_it_up/master/configs/zsh/.zshrc

wget https://raw.github.com/trapd00r/LS_COLORS/master/LS_COLORS -O $HOME/.dircolors

echo "If you would like to change your shell to zsh, please run 'chsh -s /bin/zsh'"
