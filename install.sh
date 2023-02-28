#!/usr/bin/env bash

brew_packages="git wget node@18 yarn"

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

function moveFiles() {
    cd ~/.dotfiles/files

    rsync --exclude ".git/" --exclude ".DS_Store" -avh --no-perms . ~;
}

function installBrew() {
    cd ~

    export HOMEBREW_INSTALL_FROM_API=1
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    eval "$(/opt/homebrew/bin/brew shellenv)"

    echo "Install brew packages: ${brew_packages}";
    brew install ${brew_packages}
}

function installZsh() {
    cd ~

    echo "Install zsh";
    brew install zsh
    zsh_path=$(which zsh)
    grep -Fxq "$zsh_path" /etc/shells || sudo bash -c "echo $zsh_path >> /etc/shells"
    chsh -s "$zsh_path" $USER

    source ~/.zshrc;
}

function installOhMyZsh() {
    cd ~

    echo "Install oh my zsh"
    if [ ! -d ~/.oh-my-zsh ]; then
        git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    else
        cd ~/.oh-my-zsh
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

    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc

    echo "" >> ~/.zshrc
    # echo "ZSH_THEME=\"agnoster\"" >> ~/.zshrc
    echo "ZSH_THEME=\"robbyrussell\"" >> ~/.zshrc

    echo "" >> ~/.zshrc
    echo "plugins=(" >> ~/.zshrc
    echo "    httpie" >> ~/.zshrc
    echo "    urltools" >> ~/.zshrc
    echo "    macports" >> ~/.zshrc
    echo "    ansible" >> ~/.zshrc
    echo "    isodate" >> ~/.zshrc

    echo "    git" >> ~/.zshrc
    echo "    github" >> ~/.zshrc
    echo "    git-flow" >> ~/.zshrc
    echo "    gitignore" >> ~/.zshrc
    echo "    svn" >> ~/.zshrc

    echo "    node" >> ~/.zshrc
    echo "    npm" >> ~/.zshrc
    echo "    yarn" >> ~/.zshrc
    echo "    gatsby" >> ~/.zshrc

    echo "    pip" >> ~/.zshrc
    echo "    virtualenv" >> ~/.zshrc
    echo "    python" >> ~/.zshrc

    echo "    vagrant" >> ~/.zshrc
    echo "    vagrant-prompt" >> ~/.zshrc

    echo "    docker" >> ~/.zshrc
    echo "    docker-compose" >> ~/.zshrc

    echo "    zsh-autosuggestions" >> ~/.zshrc
    echo "    zsh-syntax-highlighting" >> ~/.zshrc
    echo "    command-not-found" >> ~/.zshrc
    echo "    colored-man-pages" >> ~/.zshrc

    echo "    heroku" >> ~/.zshrc
    echo ")" >> ~/.zshrc

    echo "" >> ~/.zshrc
    echo "# Add default user" >> ~/.zshrc
    echo "DEFAULT_USER=melik" >> ~/.zshrc

    echo "" >> ~/.zshrc
    echo "source \$ZSH/oh-my-zsh.sh" >> ~/.zshrc
    echo "source ~/.aliases" >> ~/.zshrc
    echo "source ~/.functions" >> ~/.zshrc

    echo "" >> ~/.zshrc
    echo "# Stop AUTO_CD - Changing Directories" >> ~/.zshrc
    echo "unsetopt AUTO_CD" >> ~/.zshrc
    
    echo "" >> ~/.zshrc
    echo "bindkey "\e\e[D" backward-word" >> ~/.zshrc
    echo "bindkey "\e\e[C" forward-word" >> ~/.zshrc

    echo ""
    echo "${yellow}Don't forget to setup Non-ASCII Font in your Terminal App (Meslo)${reset}"
    echo ""
}

function updateBash() {
    echo 'Update Bash';

    cd ~

    if [ -e ~/.bashrc ]; then
        mv ~/.bashrc ~/.bashrc_old
    fi

    echo "Create a new bashrc configuration file .bashrc"
    touch ~/.bashrc
    echo "#!bash" >> ~/.bashrc

    echo "source ~/.profile" >> ~/.bashrc
    echo "source ~/.aliases" >> ~/.bashrc
    echo "source ~/.functions" >> ~/.bashrc

    source ~/.bashrc
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

function installOnMac() {
    sh ~/.dotfiles/macos/set_defaults.sh;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    moveFiles;
    installBrew;
    installZsh;
    installOhMyZsh;
    installOnMac;
else

    read -p "${red}This may overwrite existing config files in your home directory. Are you sure? (y/N)${reset} " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "yes\n";
        moveFiles;
    else
        echo "no\n";
    fi;

    read -p "${red}This may install Homebrew. Are you sure? (y/N)${reset} " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "yes\n";
        installBrew;
    else
        echo "no\n";
    fi;

    read -p "${red}This may update bash configs. Are you sure? (Y/n)${reset} " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "yes\n";
        updateBash;
    else
        echo "no\n";
    fi;

    read -p "${red}This may install zsh. Are you sure? (Y/n)${reset} " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "yes\n";
        installZsh;
    else
        echo "no\n";
    fi;

    read -p "${red}This may install Oh My Zsh. Are you sure? (Y/n)${reset} " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "yes\n";
        installOhMyZsh;
    else
        echo "no\n";
    fi;

    read -p "${red}This may install some macOS configurations and soft. Are you sure? (y/N)${reset} " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "yes\n";
        installOnMac;
    else
        echo "no\n";
    fi;

    read -p "${red}This may install dnsmasq and config it. Are you sure? (y/N)${reset} " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        installDnsmasq;
    else
        echo "no\n";
    fi;
fi;

if [ -e ~/.zshrc ]; then
    env zsh

    source ~/.zshrc;
fi

unset moveFiles;
unset installBrew;
unset installZsh;
unset installOhMyZsh;
unset updateBash;
unset installDnsmasq;
unset installOnMac;

cd ~
