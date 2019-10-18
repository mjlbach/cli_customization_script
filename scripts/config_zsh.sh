sudo apt install direnv

mkdir -p $HOME/.config/shell

if [ ! -d $HOME/.config/shell/powerlevel10k ]
then
    git clone https://github.com/romkatv/powerlevel10k.git $HOME/.config/shell/powerlevel10k
fi

curl -fLo ~/.zshrc \
    https://raw.githubusercontent.com/mjlbach/vim_it_up/master/configs/zsh/.zshrc

