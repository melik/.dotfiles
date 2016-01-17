#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function patchFonts() {
    # Install patch fornts for oh-my-zsh theme agnoster
    if [ ! -d .powerline_fonts ]; then
        git clone https://github.com/powerline/fonts.git .powerline_fonts
    else
        cd .powerline_fonts
        git pull
        cd -
    fi
    sh .powerline_fonts/install.sh
}

function doIt() {
    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
        --exclude "install_on_mac.sh" --exclude "sublime/" --exclude "README.md" \
        --exclude ".gitignore" --exclude ".powerline_fonts" -avh --no-perms . ~;

    # oh-my-zsh
    # Clone oh-my-zsh
    if [ ! -d ~/.oh-my-zsh ]; then
        git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    else
        cd ~/.oh-my-zsh
        git pull
        cd -
    fi

    # Create a new zsh configuration from the provided template
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

    # Add aliases
    echo ""
    echo "source ~/.aliases" >> ~/.zshrc
    echo "source ~/.functions" >> ~/.zshrc
    # Customize theme
    sed -i -e 's/ZSH_THEME=".*"/ZSH_THEME="agnoster"/' ~/.zshrc
    # Config plugins
    sed -i -e 's/plugins=(.*)/plugins=(rspec git github gitignore svn node npm pip virtualenv python macports colored-man-pages vagrant)/' ~/.zshrc

    # Add default user
    echo ""
    echo "DEFAULT_USER="$USER >> ~/.zshrc
    echo ""

    env zsh

    source ~/.zshrc;
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
