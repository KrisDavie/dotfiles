#!/bin/bash

DOTFILES_DIR="${HOME}/git/dotfiles"
DOTFILES_OLD="${HOME}/.dotfiles_old_"$(date +%Y%M%d_%H%M%S)

DIRS=".ssh .zsh"
FILES=".bashrc .bash_profile .gitconfig .ssh/config .tmux.conf .zshenv .zsh/.zshrc"    # list of files/folders to symlink in homedir

cd ${DOTFILES_DIR}
mkdir -p ${DOTFILES_OLD}

## oh-my-zsh 
mv ${HOME}/.oh-my-zsh ${DOTFILES_OLD} 2>/dev/null
cd ${HOME}
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

ZSH_CUSTOM=${HOME}/.oh-my-zsh/custom

git clone https://github.com/MichaelAquilina/zsh-you-should-use.git  ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/you-should-use
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/spaceship-prompt

ln -s "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/spaceship.zsh-theme"
mv ${HOME}/.zshrc.pre-oh-my-zsh ${DOTFILES_OLD} 2>/dev/null
rm ${HOME}/.zshrc
cd ${DOTFILES_DIR}

## Dotfiles

for DIR in ${DIRS}; do
    mkdir -p ${HOME}/${DIR}
    mkdir -p ${DOTFILES_OLD}/${DIR}
done

if [ ! -f '${HOME}/.local/bin/blackbox_initialize' ]; then
    mkdir -p ${HOME}/git ${HOME}/.local/bin/
    cd ${HOME}/git
    git clone https://github.com/StackExchange/blackbox.git
    cd blackbox
    cp -R bin ${HOME}/.local/
    cd ${HOME}/git && rm -rf blackbox
fi


# Build .bashrc
cd ${DOTFILES_DIR}
cat ${DOTFILES_DIR}/profiles/.profile_common > .bashrc

if [ ${VSC_INSTITUTE:-"none"} == "leuven" ]; then
	cat  ${DOTFILES_DIR}/profiles/.profile_vsc >> .bashrc
    FILES+=" .zsh/.zsh_module_fix"
elif [ ${USER} == 'u0094113' ]; then
	cat  ${DOTFILES_DIR}/profiles/.profile_luna >> .bashrc
else
	cat  ${DOTFILES_DIR}/profiles/.profile_personal >> .bashrc
fi

for FILE in ${FILES}; do
    mv ${HOME}/${FILE} ${DOTFILES_OLD} 2>/dev/null
    ln -sf ${DOTFILES_DIR}/${FILE} ${HOME}/${FILE}
done

touch ${HOME}/.z

