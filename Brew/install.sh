source config.sh

echo "${blue}Install Brew${reset}";

# cd ~

export HOMEBREW_INSTALL_FROM_API=1
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "${blue}Install Brew packages${reset}";
brew install git
brew install svn
brew install wget
brew install curl
brew install httpie
brew install node
brew install nano
brew install tree
brew install python


echo "${blue}Install App from Brew${reset}";
brew install --cask google-chrome
brew install --cask zoom
brew install --cask mpv
brew install --cask dropbox

brew install --cask iterm2
brew install --cask visual-studio-code
brew install --cask docker

brew install --cask vlc
