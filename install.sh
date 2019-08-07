#!/bin/bash

DOTFILES_DIR="~/git/dotfiles"
DOTFILES_OLD="~/.dotfiles_old_"$(date --iso-8601)

FILES="bashrc bash_profile zshrc tmux.conf"    # list of files/folders to symlink in homedir

cd ${DOTFILES_DIR}

cat ${DOTFILES_DIR}/profiles/.profile_common > .bashrc

if [ ! -f '~/.local/bin/blackbox_initialize' ]; then
    mkdir -p ~/git
    cd ~/git
    git clone https://github.com/StackExchange/blackbox.git
    cd blackbox
    cp -R bin ~/.local/
    cd ~/git && rm -rf blackbox
fi


if [ ${VSC_INSTITUTE} == "leuven" ]; then
	cat  ${DOTFILES_DIR}/profiles/.profile_vsc >> .bashrc
    FILES+=" zsh_module_fix"
elif [ ${USER} == 'u0094113' ]; then
	cat  ${DOTFILES_DIR}/profiles/.profile_luna >> .bashrc
else
	cat  ${DOTFILES_DIR}/profiles/.profile_personal >> .bashrc
fi

mkdir -p ${DOTFILES_OLD}

for FILE in ${FILES}; do
    mv ~/.${FILE} ${DOTFILES_OLD}
    ln -s ${DOTFILES_DIR}/${FILE} ~/.${FILE}
done

mkdir -p ~/.ssh ${DOTFILES_OLD}/.ssh
mv ~/.ssh/config  ${DOTFILES_OLD}/.ssh/config
