export ZSH="${HOME}/.oh-my-zsh"

export PATH=${HOME}/.local/bin/:${PATH}

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

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

. $ZSH/oh-my-zsh.sh

# Load VSC module system
if [[ ${VSC_INSTITUTE:-"none"} == "leuven" ]]; then
    . ${HOME}/.zsh/.zsh_module_load zsh
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"
