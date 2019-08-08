#!/bin/bash

DOTFILES_DIR="~/git/dotfiles"
DOTFILES_OLD="~/.dotfiles_old_"$(date --iso-8601)

DIRS=".ssh .zsh"
FILES=".bashrc .bash_profile .gitconfig .ssh/config .tmux.conf .zshenv .zsh/.zshrc"    # list of files/folders to symlink in homedir

cd ${DOTFILES_DIR}
mkdir -p ${DOTFILES_OLD}

for DIR in ${DIRS}; do
    mkdir -p ~/.${DIR}
    mkdir -p ${DOTFILES_OLD}/${DIR}
done

for FILE in ${FILES}; do
    mv ~/.${FILE} ${DOTFILES_OLD}
    ln -s ${DOTFILES_DIR}/${FILE} ~/${FILE}
done


if [ ! -f '~/.local/bin/blackbox_initialize' ]; then
    mkdir -p ~/git ~/.local/bin/
    cd ~/git
    git clone https://github.com/StackExchange/blackbox.git
    cd blackbox
    cp -R bin ~/.local/
    cd ~/git && rm -rf blackbox
fi


# Build .bashrc

cat ${DOTFILES_DIR}/profiles/.profile_common > .bashrc

if [ ${VSC_INSTITUTE} == "leuven" ]; then
	cat  ${DOTFILES_DIR}/profiles/.profile_vsc >> .bashrc
    FILES+=" .zsh/.zsh_module_fix"
elif [ ${USER} == 'u0094113' ]; then
	cat  ${DOTFILES_DIR}/profiles/.profile_luna >> .bashrc
else
	cat  ${DOTFILES_DIR}/profiles/.profile_personal >> .bashrc
fi

## oh-my-zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

ZSH_CUSTOM=~/.oh-my-zsh/custom

git clone https://github.com/MichaelAquilina/zsh-you-should-use.git  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt

ln -s "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship.zsh-theme"
