source const.sh

echo "${blue}Update Git${reset}";

echo "Create a new git configuration file .gitconfig"
if [ -e ~/.gitconfig ]; then
    mv ~/.gitconfig ~/.gitconfig_old
fi

cp ./Git/files/.gitconfig ~/.gitconfig
