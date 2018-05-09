#!/usr/bin/env bash

black=$'\e[30m';
red=$'\e[31m';
green=$'\e[32m';
yellow=$'\e[33m';
blue=$'\e[34m';
purple=$'\e[35m';
cyan=$'\e[36m';
gray=$'\e[37m';
reset=$'\e[0m';

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function patchFonts() {
    cd ~

    # Install patch fornts for oh-my-zsh theme agnoster
    echo "Install Powerline Fonts"
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
        --exclude ".gitignore" -avh --no-perms . ~;

    # oh-my-zsh
    # Clone oh-my-zsh
    echo "Install oh my zsh"
    if [ ! -d ~/.oh-my-zsh ]; then
        git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    else
        cd ~/.oh-my-zsh
        git pull
        cd ~
    fi

    echo "Install Powerlevel9k"
    if [ ! -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]; then
        git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    else
        cd ~/.oh-my-zsh/custom/themes/powerlevel9k
        git pull
        cd ~
    fi

    echo "Install custom plugins for Oh My Zsh:"
    echo "- zsh-syntax-highlighting"
    if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    else
        cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
        git pull
        cd ~
    fi

    echo "- zsh-autosuggestions"
    if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    else
        cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
        git pull
        cd ~
    fi

    # Create a new zsh configuration from the provided template
    # cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

    # Create a new zsh configuration from null
    echo "Create a new zsh configuration file .zshrc"

    if [ -e ~/.zshrc ]; then
        rm ~/.zshrc
    fi

    echo "" >> ~/.zshrc
    echo "export ZSH=\$HOME/.oh-my-zsh" >> ~/.zshrc

    echo "" >> ~/.zshrc
    # echo "ZSH_THEME=\"agnoster\"" >> ~/.zshrc
    echo "ZSH_THEME=\"powerlevel9k/powerlevel9k\"" >> ~/.zshrc

    echo "" >> ~/.zshrc
    echo "plugins=(httpie urltools profiles iwhois heroku rspec git gitignore git-prompt github git-flow gitignore svn node npm yarn pip virtualenv python macports colored-man-pages vagrant django docker-compose docker zsh-autosuggestions zsh-syntax-highlighting)" >> ~/.zshrc

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

    echo "# Settings for POWERLEVEL9K" >> ~/.zshrc
    echo "# https://github.com/bhilburn/powerlevel9k" >> ~/.zshrc
    echo "POWERLEVEL9K_PROMPT_ADD_NEWLINE=true" >> ~/.zshrc
    echo "# POWERLEVEL9K_PROMPT_ON_NEWLINE=true" >> ~/.zshrc
    echo "# POWERLEVEL9K_RPROMPT_ON_NEWLINE=true" >> ~/.zshrc

    echo ""
    echo "${yellow}Don't forget to setup Non-ASCII Font in your Terminal App (Meslo)${reset}"
    echo ""

    cd ~
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    patchFonts;
    doIt;
else
    read -p "${red}This may patch fonts for oh-my-zsh's theme. Are you sure? (y/N)${reset} " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "yes"
        patchFonts;
    else
        echo "no"
    fi;

    read -p "${red}This may overwrite existing files in your home directory. Are you sure? (y/N)${reset} " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "yes"
        doIt;
    else
        echo "no"
    fi;
fi;

cd ~

env zsh

source ~/.zshrc;

unset doIt;
unset patchFonts;
