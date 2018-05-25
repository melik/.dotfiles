#!/usr/bin/env bash

# Font colors for markup
export black=$'\e[30m';
export red=$'\e[31m';
export green=$'\e[32m';
export yellow=$'\e[33m';
export blue=$'\e[34m';
export purple=$'\e[35m';
export cyan=$'\e[36m';
export gray=$'\e[37m';

export reset=$'\e[0m';


# Scripts
reset

cd "$(dirname "${BASH_SOURCE}")";

echo "${yellow}Check updates${reset}";

git pull origin master;


read -p "${red}This may install Homebrew. Are you sure? (y/N)${reset} " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "yes";
    cd "$(dirname "${BASH_SOURCE}")";
    sh scripts/homebrew.sh
else
    echo "no"
fi;

read -p "${red}This may install dnsmasq and config it. Are you sure? (y/N)${reset} " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "yes";
    cd "$(dirname "${BASH_SOURCE}")";
    sh scripts/dnsmasq.sh
else
    echo "no"
fi;

read -p "${red}This may sync Atom config from Dropbox. Are you sure? (y/N)${reset} " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "yes";
    cd "$(dirname "${BASH_SOURCE}")";
    sh scripts/atom_sync.sh
else
    echo "no"
fi;

read -p "${red}This may install zsh and oh-my-zsh packages. Are you sure? (Y/n)${reset} " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "yes"
    cd "$(dirname "${BASH_SOURCE}")";
    sh scripts/zsh.sh
else
    echo "no"
    read -p "${red}This may update Bash Shell. Are you sure? (Y/n)${reset} " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "yes"
        cd "$(dirname "${BASH_SOURCE}")";
        sh scripts/bash.sh
    else
        echo "no"
    fi;
fi;

cd "$(dirname "${BASH_SOURCE}")";
