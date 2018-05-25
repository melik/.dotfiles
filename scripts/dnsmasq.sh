#!/usr/bin/env bash

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
