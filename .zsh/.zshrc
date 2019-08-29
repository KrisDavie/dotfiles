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

source $ZSH/oh-my-zsh.sh

# Fix VSC module system
if [[ ${VSC_INSTITUTE:-"none"} == "leuven" ]]; then
    source ${HOME}/.zsh/.zsh_module_fix
    module load tmux/2.9a-GCCcore-6.4.0
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"
