export ZSH="${HOME}/.oh-my-zsh"

export PATH=${HOME}/.local/bin/:${PATH}

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
    module load tmux/2.9a-foss-2018a
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"
