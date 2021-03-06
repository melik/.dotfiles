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

function doIt() {
    cd ~

    brew install wget

    brew install zsh
    zsh_path=$(which zsh)
    grep -Fxq "$zsh_path" /etc/shells || sudo bash -c "echo $zsh_path >> /etc/shells"
    chsh -s "$zsh_path" $USER

    sh ~/.dotfiles/bootstrap.sh;

    cd ~
}

function updateAtom() {
    cd ~/.atom/

    if [ -d .apm ]; then
        rm -rf .apm
    fi
    if [ -d packages ]; then
        rm -rf packages
    fi
    if [ -f config.cson ]; then
        rm config.cson
    fi
    if [ -f github.cson ]; then
        rm github.cson
    fi
    if [ -f init.coffee ]; then
        rm init.coffee
    fi
    if [ -f keymap.cson ]; then
        rm keymap.cson
    fi
    if [ -f snippets.cson ]; then
        rm snippets.cson
    fi
    if [ -f styles.less ]; then
        rm styles.less
    fi
    if [ -f package-deps-state.json ]; then
        rm package-deps-state.json
    fi

    ln -s ~/Dropbox/Applications/Atom/.apm .apm
    ln -s ~/Dropbox/Applications/Atom/packages packages
    ln -s ~/Dropbox/Applications/Atom/config.cson config.cson
    ln -s ~/Dropbox/Applications/Atom/github.cson github.cson
    ln -s ~/Dropbox/Applications/Atom/init.coffee init.coffee
    ln -s ~/Dropbox/Applications/Atom/keymap.cson keymap.cson
    ln -s ~/Dropbox/Applications/Atom/snippets.cson snippets.cson
    ln -s ~/Dropbox/Applications/Atom/styles.less styles.less
    ln -s ~/Dropbox/Applications/Atom/package-deps-state.json package-deps-state.json

    cd ~
}

function installBrew() {
    cd ~

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    cd ~
}

function installDnsmasq() {
    cd ~

    brew install dnsmasq

    echo ""

    cd $(brew --prefix)

    mkdir -p etc

    echo "Copy the default configuration file"
    cp $(brew list dnsmasq | grep /dnsmasq.conf.example$) /usr/local/etc/dnsmasq.conf

    read -p "Insert 'address=/test/10.60.17.154' in file '"$(brew --prefix)"/etc/dnsmasq.conf'. Are you sure? (y/N) " -n 1
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo '' >> etc/dnsmasq.conf
        echo 'address=/test/10.60.17.154' >> etc/dnsmasq.conf
        echo ""
        echo "Update '$(brew --prefix)/etc/dnsmasq.conf'";
    fi;

    echo ""
    # Copy the daemon configuration file into place.
    sudo cp $(brew list dnsmasq | grep /homebrew.mxcl.dnsmasq.plist$) /Library/LaunchDaemons/
    sudo chown root /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
    # Start Dnsmasq automatically.
    sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist

    sudo mkdir -p /etc/resolver

    sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'
    echo ""
    echo "Update '/etc/resolver/test'";

    echo ""

    cd ~
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    installBrew;
    installDnsmasq;
    doIt;
else
    read -p "${red}This may install Homebrew. Are you sure? (y/N)${reset} " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "yes";
        installBrew;
    else
        echo "no"
    fi;

    read -p "${red}This may install dnsmasq and config it. Are you sure? (y/N)${reset} " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "yes";
        installDnsmasq;
    else
        echo "no"
    fi;

    read -p "${red}Did you install Atom and Dropbox? Move '.atom' to Dropbox? (y/N)${reset} " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "yes";
        updateAtom;
    else
        echo "no"
    fi;

    read -p "${red}This may install other packages. Are you sure? (Y/n)${reset} " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "no"
    else
        echo "yes"
        doIt;
    fi;
fi;

unset doIt;
unset updateAtom;
unset installDnsmasq;
unset installBrew;

cd ~
