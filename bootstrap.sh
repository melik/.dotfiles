#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function patchFonts() {
    # Install patch fornts for oh-my-zsh theme agnoster
    if [ ! -d ~/.powerline_fonts ]; then
        git clone https://github.com/powerline/fonts.git ~/.powerline_fonts
    else
        cd ~/.powerline_fonts
        git pull
        cd -
    fi
    sh ~/.powerline_fonts/install.sh

    rm -rf ~/.powerline_fonts

    cd ~
}

function doIt() {
    cd ~/.dotfiles

    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
        --exclude "install_on_mac.sh" --exclude "README.md" \
        --exclude ".gitignore" --exclude ".powerline_fonts" -avh --no-perms . ~;

    # oh-my-zsh
    # Clone oh-my-zsh
    if [ ! -d ~/.oh-my-zsh ]; then
        git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    else
        cd ~/.oh-my-zsh
        git pull
        cd ~
    fi

    # Create a new zsh configuration from the provided template
    # cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

    # Prepare .zshrc
    echo ""
    echo "Prepare .zshrc"

    rm ~/.zshrc
    echo "" >> ~/.zshrc
    echo "export ZSH=\$HOME/.oh-my-zsh" >> ~/.zshrc

    echo "" >> ~/.zshrc
    echo "ZSH_THEME=\"agnoster\"" >> ~/.zshrc

    echo "" >> ~/.zshrc
    echo "plugins=(rspec git github gitignore svn node npm yarn pip virtualenv python macports colored-man-pages vagrant django docker-compose docker)" >> ~/.zshrc

    echo "" >> ~/.zshrc
    echo "# Add default user" >> ~/.zshrc
    echo "DEFAULT_USER=melik" >> ~/.zshrc

    echo "" >> ~/.zshrc
    echo "# Stop AUTO_CD - Changing Directories" >> ~/.zshrc
    echo "unsetopt AUTO_CD" >> ~/.zshrc

    echo "" >> ~/.zshrc
    echo "source \$ZSH/oh-my-zsh.sh" >> ~/.zshrc
    echo "source ~/.aliases" >> ~/.zshrc
    echo "source ~/.functions" >> ~/.zshrc

    env zsh

    source ~/.zshrc;

    cd ~
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    patchFonts;
    doIt;
else
    read -p "This may patch fonts for oh-my-zsh's theme. Are you sure? (y/N) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        patchFonts;
    fi;

    read -p "This may overwrite existing files in your home directory. Are you sure? (y/N) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt;
    fi;
fi;

unset doIt;
unset patchFonts;

cd ~
