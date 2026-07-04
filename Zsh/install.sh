source config.sh

echo "${blue}Install Zsh${reset}";

brew install zsh
zsh_path=$(which zsh)
grep -Fxq "$zsh_path" /etc/shells || sudo bash -c "echo $zsh_path >> /etc/shells"
chsh -s "$zsh_path" $USER

echo "${blue}Install ohmyzsh${reset}";
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
echo "Install custom plugins for Oh My Zsh:"
echo "- zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
echo "- zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

echo "Create a new zsh configuration file .zshrc"
if [ -e ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc_old
fi

cp ./Zsh/files/.zshrc ~/.zshrc

echo "\n${green}Don't forget to setup Non-ASCII Font in your Terminal App (Meslo)${reset}\n"

source ~/.zshrc;

env zsh
