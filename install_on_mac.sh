#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

function doIt() {
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    brew install zsh
    chsh -s /usr/local/bin/zsh

    brew install wget

    brew install dnsmasq
}

function installDnsmasq() {
    echo ""

    cd $(brew --prefix)

    mkdir -p etc

    echo "Copy the default configuration file"
    cp $(brew list dnsmasq | grep /dnsmasq.conf.example$) /usr/local/etc/dnsmasq.conf

    read -p "Insert 'address=/.dev/192.168.50.4' in file '"$(brew --prefix)"/etc/dnsmasq.conf'. Are you sure? (y/n) " -n 1
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo 'address=/.dev/192.168.50.4' >> etc/dnsmasq.conf
        echo ""
        echo "Update '$(brew --prefix)/etc/dnsmasq.conf'";
    fi;

    echo ""
    sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons
    sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist

    sudo mkdir -p /etc/resolver

    echo ""
    read -p "Insert 'nameserver 192.168.50.4' in file '/etc/resolver/dev'. Are you sure? (y/n) " -n 1
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo bash -c 'echo "nameserver 192.168.50.4" > /etc/resolver/dev'
        echo ""
        echo "Update '/etc/resolver/dev'";
    fi;

    echo ""
    cd -
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt;
    installDnsmasq;
else
    read -p "This may install Homebrew and other packeges. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt;
    fi;

    read -p "Now this may install dnsmasq and config it. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        installDnsmasq;
    fi;
fi;

unset doIt;
unset installDnsmasq;
