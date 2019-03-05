### Requirements

* Ubuntu 16.04 or 18.04 (maybe any debian based system? Not sure about package names...)
* Any linux system if you modify package manager commands
* Bash (probably any POSIX compliant shell)

### Instructions
 
* Run the following two commands to install the settings. Your tmux config and neovim config will be backed up *each time you run this script* overwriting the previous backup:

```

curl https://raw.githubusercontent.com/mjlbach/vim_it_up/master/vimitup.sh -sSf | bash 
source $HOME/.bashrc

```

* To update to my latest defaults and install the latest rust compiler/shell programs. Warning, this does not backup your configuration files and will overwrite your tmux and neovim config
```
curl https://raw.githubusercontent.com/mjlbach/vim_it_up/master/update.sh -sSf | bash 
source $HOME/.bashrc
```

* If you would like an up-to-date TMUX 2.8 includes true color support, otherwise your vim is not going to have the correct coloring inside tmux) and either A) Do not have root or B) don't want to add a PPA/backport to your stable server environment, run the included install tmux script and ensure that $HOME/local/bin is on your system path. Ensure libevent is installed (apt-get install libevent-dev)

```
export CPPFLAGS="-P"
curl https://raw.githubusercontent.com/mjlbach/vim_it_up/master/install_latest_tmux.sh -sSf | bash
```

* If you would like the latest mosh (mobile-shell) which includes true color support.

```
curl https://raw.githubusercontent.com/mjlbach/vim_it_up/master/install_mosh.sh -sSf | bash
```

Again, ensure that $HOME/local/bin is on your system path. Your client MOSH needs to also be the latest version (brew install mosh --HEAD).

If you need to add the tmux-256color profile to your cluster:

https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be

### Features

* tmux
* mosh
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
    
### Musings on useful features (by no means exhaustive)
* fd
    * typing fd \[expression\] will find all files matching expression recursively in current directory. Basically like find . -name \[expression\] but significantly faster.
* fzf
    * if you type \<ctrl\>\<r> you will have an interactive listing of all previous commands. 
    * if you type \<ctrl\>\<t> you will be able to populate a filename at current position of cursor. 
    * if you type \<alt\>\<c> you will be jump to the selected folder.
    * if you type ** after a command and hit tab, you will have an interactive selector for files. (try nvim **)
* exa
    * exa is basically colored ls, same mappings. Try adding an alias ll="exa -alh"
* rg
    * rg is basically turbocharged grep. It's faster. Try rg import in the home directory of any python project to search for an import statement.
    
* TMUX
    * \<ctrl\>\<a\> is now the default tmux prefix, try holding control down while pressing a twice to switch panes.
    * ctrl + vim hjkl bindings now in a unified way navigate you between vim and tmux
    * If you installed with the included script, true colors and italics should work
    
* mosh
   * mosh is an uniteruptible, almost lag-free UDP based remote shell that persists across reboots/dropped connections. The initial handshake uses ssh and thus can use your ssh alias. After installing try "mosh --server=~/local/bin/mosh-server REMOTE_HOST"
   
    
* neovim
    * fzf
        * space is now leader key and most fzf commands are mapped to \<space\>\<key\>
        * \<space\>\<space\> pulls up an interactive list of open buffers. \<space\>\<space\>\<return\> jumps to last open buffer.
        * \<space\>s interactive searches for a string across your entire project with ripgrep.
        * \<space\>f pulls up an interactive list of all files in your git repo.
        * \<space\>t runs ctags with gutentags and pulls up a list of all methods/classes across your git repo.
        * \<space\>l pulls up a list of all lines in your current buffer. 
     
     * Language server
        * So long as you have an activated python environment with python-language-server installed (pip install python-language-server[all]) you will get code completion. \<ctrl\>\<n\> selects the next completion result. \<ctrl\>\<p\> selects the previous completion result.
        * gd in normal mode jumps to the definition of the method of your cursor across projects.
        * \<shift\>\<K\> in normal mode pulls up the definition of your method (including your own defined docstrings\>
        * F5 is the shortcut for major LSP features (refactoring, renaming, reformatting)
        * F2 renames current symbol
 
   * vim fugitive
        * :Gread [git branch]:path/to/your/file opens the file from the branch/path in your selected buffer
        * :Gdiff [git branch]:path/to/your/file (or currentfile use %) [git branch]:path/to/your/file opens vim diff between two branches/your file and master
        
   * vim commentary
       * gcc on current line comments it out
       * gc on selection comments block
       
   * Custom Michael-maps
       * \<space\>d opens a sidebar like nerdtree using netrw
       * F3 toggles paste mode
       * \<alt\>j moves current line down, \<alt\>k moves line up
       * F6 trims trailing whitespace
       * F9 can be configured to asynchronously run the current python file
       * gqq formats open json files
       * n always searches forward (for / and ?), N always searches backwards
 
 
### FAQ

* Why neovim? 

Neovim is packaged as an appimage, which means that this script, as a whole, installs a somewhat deterministic mesh of the editor and plugins that *just works*. With one or two modifications, this entire script works with vanilla-vim. Honestly though, the two are almost identical. Neovim has more robust python/lua APIs for plugins, implemented asynchronous plugins first, and is helping encourage Bram to push vim forward.


* Why? 

I like programming diretly on my remote servers because I rely on many plugins that become varying degrees of broken/slow on an sshfs mount or opening with netrw (vim-fugitive, project searching with fzf/ctags). This script recaptures 90% of my development environment in less than a minute.

### Please send suggestions! 
I'm always looking for new optimizations/tweaks. I try to keep the plugin count narrow, so if there's something vanilla-vim does better with < 20 lines of vimscript let me know.
