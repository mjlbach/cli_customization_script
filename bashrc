  bind 'TAB:menu-complete'
  bind "set completion-ignore-case on"
  bind "set show-all-if-ambiguous on"

  [ -f ~/.fzf.bash ] && source ~/.fzf.bash

  alias nvim=/home/mjlbach/.neovim/nvim.appimage

  export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-re  po).
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
  export FZF_DEFAULT_COMMAND='fd --type f'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export EDITOR=$HOME/.neovim/nvim.appimage

  show_virtual_env() {
    if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    ¦ echo "($(basename $VIRTUAL_ENV)) "
    fi
  }
  export -f show_virtual_env

  PS1='$(show_virtual_env)'$PS1<Paste>
