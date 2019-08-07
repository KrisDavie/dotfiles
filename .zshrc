export ZSH="${HOME}/.oh-my-zsh"

export PATH=~/.local/bin/:${PATH}

ZSH_THEME="spaceship"

plugins=(
  git
  history
  sudo
  tmux
  wd
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

export ZSH_COMPDUMP="~/.cache/zsh"

source $ZSH/oh-my-zsh.sh

# Fix VSC module system
if [ ${VSC_INSTITUTE} == "leuven" ]; then
    source ~/.zsh_module_fix
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"
