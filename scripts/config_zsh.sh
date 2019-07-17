mkdir -p $HOME/.config/shell

if [ ! -d $HOME/.config/shell/powerlevel10k ]
then
    git clone https://github.com/romkatv/powerlevel10k.git $HOME/.config/shell/powerlevel10k
fi

cd $HOME/.config/shell
curl -fsSLO https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower
sed -i'' -e 's/POWERLEVEL9K_SHOW_RULER=true/POWERLEVEL9K_SHOW_RULER=false/g' .purepower
cd $HOME
