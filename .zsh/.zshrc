export ZSH="${HOME}/.oh-my-zsh"

export PATH=~/.local/bin/:${PATH}

ZSH_THEME="spaceship"

plugins=(
  git
  history
  sudo
  tmux
  wd
  you-should-use
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

export ZSH_COMPDUMP="~/.cache/zsh"

source $ZSH/oh-my-zsh.sh

# Fix VSC module system
if [[ ${VSC_INSTITUTE:-"none"} == "leuven" ]]; then
    source ~/.zsh/.zsh_module_fix
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"
