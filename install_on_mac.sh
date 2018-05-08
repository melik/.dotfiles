#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
    cd ~

    brew install wget

    brew install zsh
    zsh_path=$(which zsh)
    grep -Fxq "$zsh_path" /etc/shells || sudo bash -c "echo $zsh_path >> /etc/shells"
    chsh -s "$zsh_path" $USER

    updateAtom;

    cd ~
}

function updateAtom() {
    cd ~

    read -p "Did you install Atom and Dropbox? Move '.atom' to Dropbox? (y/N) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      rm -rf ~/.atom
      ln -s ~/Dropbox/Приложения/Atom ~/.atom
    fi;

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
    read -p "This may install Homebrew. Are you sure? (y/N) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        installBrew;
    fi;

    read -p "This may install dnsmasq and config it. Are you sure? (y/N) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        installDnsmasq;
    fi;

    read -p "This may install other packages. Are you sure? (y/N) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt;
    fi;
fi;

sh ~/.dotfiles/bootstrap.sh

unset doIt;
unset updateAtom;
unset installDnsmasq;
unset installBrew;

cd ~
