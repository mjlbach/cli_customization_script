### Requirements

* Ubuntu 16.04 or 18.04 (maybe any debian based system? Not sure about package names...)
* Bash 

### Instructions
 
* Run the following two commands:

```

curl https://raw.githubusercontent.com/mjlbach/vim_it_up/master/vimitup.sh -sSf | bash 
source $HOME/.bashrc

```

### Features

* tmux
* fzf 
* bat
* rg
* fd
* neovim with:
    * Sensible leader key mappings
    * A Gruvy colorscheme
    * Git integration through vim-fugitive
    * Fuzzy jumping to tags (function and metho names), files, buffers, general strings, and more
    * Language server support (pip install python-language-server[all] in any activated virtual environment)

### FAQ

* Why neovim? 

It comes with an appimage which makes it more modular, also it has more robust plugin support. Most of these plugins are vim compatible with minor modifications.

* Why? 

I program remotely on several different machines. This script makes it easy to replicate ~90% of my development environment anywhere. I typically program with ssh connected to a remote  vim 
