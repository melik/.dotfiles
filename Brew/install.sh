source const.sh

echo "${blue}Install Brew${reset}";

# cd ~

# Navigate to cd /opt/homebrew/bin/
# Run export PATH=$PATH:/opt/homebrew/bin
# Navigate back to "home" with cd ~/
# in this directory I found that there was no .zshrc file (:scream:)
# So I created a file with touch .zshrc and then
# ran this command: echo export PATH=$PATH:/opt/homebrew/bin >> .zshrc

export HOMEBREW_INSTALL_FROM_API=1
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

cd /opt/homebrew/bin/
export PATH=$PATH:/opt/homebrew/bin
cd -

echo "${blue}Install Brew packages${reset}";
brew install git
brew install gh
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
