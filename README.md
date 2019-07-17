### Requirements

* Ubuntu 16.04 or 18.04

### Instructions
 
* To install the config, run the following commands. Your tmux config and neovim config will be backed up *each time you run this script* (overwriting the previous backup):

```

curl https://raw.githubusercontent.com/mjlbach/vim_it_up/master/scripts/vimitup.sh -sSf | bash 
source $HOME/.bashrc

```

* To upgrade your config, run the following commands. This does not backup your configuration files and will overwrite your tmux and neovim config:
```
curl https://raw.githubusercontent.com/mjlbach/vim_it_up/master/scripts/update.sh -sSf | bash 
source $HOME/.bashrc
```

* The tmux available in most package managers is out of date. TMUX 2.9a includes true color support amongst others improvements. Run the following command to compile and install:

```
curl https://raw.githubusercontent.com/mjlbach/vim_it_up/master/scripts/install_tmux.sh -sSf | bash
```
You may need to add the [tmux-256color](https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be) profile to your cluster:

```
echo "xterm-256color-italic|xterm with 256 colors and italic,
  sitm=\E[3m, ritm=\E[23m,
  use=xterm-256color," > xterm-256color-italic.terminfo" \
  && tic -x xterm-256color-italic.terminfo \ 
  && rm xterm-256color-italic.terminfo"
  
echo "tmux-256color|tmux with 256 colors,
  ritm=\E[23m, rmso=\E[27m, sitm=\E[3m, smso=\E[7m, Ms@,
  khome=\E[1~, kend=\E[4~,
  use=xterm-256color, use=screen-256color," > tmux-256color.terminfo" \
  && tic -x tmux-256color.terminfo && \
  rm tmux-256color.terminfo"
``` 

* If you would like the latest mosh (mobile-shell) which includes true color support, run the following compile script. Note that this installs mosh server & client on your remote host, your client MOSH needs to also be the latest version (for example: brew install mosh --HEAD on macOS or running the same buidl script on your local linux machine).

```
curl https://raw.githubusercontent.com/mjlbach/vim_it_up/master/scripts/install_mosh.sh -sSf | bash
```

Ensure that $HOME/local/bin is on your system path, ahead of /usr/bin to use the locally installed tmux and mosh.

If you are using Salt to manage a cluster, you can run one of these scripts across all of your nodes by the following command:

```
sudo salt '*' cmd.run runas=mjlbach 'curl https://raw.githubusercontent.com/mjlbach/vim_it_up/master/scripts/install_l
atest_tmux.sh -sSf | bash'
```

### Features

* tmux - terminal multiplexer
* mosh - mobile shell that persists across poor wifi connections
* fzf - fuzzy finding for commands & files
* bat - colorized cat
* rg - faster grep
* fd - faster find
* sd - faster sed

* neovim with:
    * Sensible leader key mappings
    * A nice default colorscheme
    * Git integration through vim-fugitive
    * Fuzzy jumping to tags, files, buffers, general strings, etc.
    * Language server support through coc.nvim
    
### Musings on useful features (by no means exhaustive)
* fd
    * typing fd \[expression\] will find all files matching expression recursively in current directory. Analogous to find . -name \[expression\] but significantly faster and with easier syntax.
* fzf
    * \<ctrl\>\<r> will interactively list previous shell commands. 
    * \<ctrl\>\<t> will interactively and recursively list files within the current directory and append to the current shell command. 
    * \<alt\>\<c> will interactively list subdirectories and upon selection jump to the directory.
    * Typing ** after a command and hitting tab will interactively list files and upon selection append to the current command. (try nvim **)
* exa
    * exa is a colored, faster ls. Try adding an alias ll="exa -alh"
* rg
    * rg is a faster grep with easier command syntax. Try "rg import" in the home directory of any python project to search for import statements.
    
* TMUX
    * \<ctrl\>\<a\> is now the default tmux prefix, try holding control and pressing a twice to switch panes.
    * ctrl + hjkl now switch panes, even if vim is open in one of the panes (vim-tmux-navigator)
    * If you used the compile script, true colors and italics should work
    
* mosh
   * mosh is a low latency, UDP based remote shell that persists across reboots/dropped connections. The initial handshake uses ssh and can use your ssh aliases. After installing try "mosh --server=~/local/bin/mosh-server REMOTE_HOST"
   
    
* neovim
    * fzf
        * space is now the leader key and fzf commands are mapped to \<space\>\<key\>
        * \<space\>\<space\> pulls up an interactive list of open buffers. \<space\>\<space\>\<cr\> jumps to last open buffer.
        * \<space\>s interactively searches for a string across your entire project from the git root directory with ripgrep.
        * \<space\>f interactively lists of all files in your project.
        * \<space\>t runs ctags with gutentags and pulls up a list of all functions/classes across your git repo.
        * \<space\>l pulls up a list of all lines in your current buffer. 
     
     * Language server
        * Ensure flake8, rope, black, and jedi are installed in your current virtualenvironment or user site-packages
        * gd in normal mode jumps to the definition of the method of your cursor across projects.
        * \<shift\>\<K\> in normal mode pulls up the definition of your method (including your own defined docstrings\>
        * \<space\>rn renames the current symbol
 
     * vim fugitive
        * :Gread [git branch]:path/to/your/file opens the file from the branch/path in your selected buffer
        * :Gdiff [git branch]:path/to/your/file (or for the current file use %) [git branch]:path/to/your/file opens a diff between two branches/your file and master
        
     * vim commentary
       * gcc on the current line comments it out
       * gc on a visual selection comments out the block
       
     * Custom maps
       * \<space\>d opens a directory listing in the sidebar using netrw
       * \<alt\>j moves current line down, \<alt\>k moves line up
       * F3 toggles paste mode
       * F6 trims trailing whitespace
       * F9 can be configured to asynchronously run the current python file
       * F10 Removes line numbers and indent guides for copy and pasting
       * gqq formats open json files
       * n always searches forward (for / and ?), N always searches backwards
 
 
### FAQ

* Why neovim? 

Neovim is packaged as an appimage which makes it very portable and has more robust built-in plugin support. This configuration works with vanilla vim with one or two modifications for coc.nvim.

### Please send suggestions! 
I'm always looking for new optimizations and tweaks.
