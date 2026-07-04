source const.sh

echo "${blue}Update Bash${reset}";

if [ -e ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc_old
fi

cp ./Bash/files/.aliases ~/.aliases
cp ./Bash/files/.bashrc ~/.bashrc
cp ./Bash/files/.editorconfig ~/.editorconfig
cp ./Bash/files/.functions ~/.functions
cp ./Bash/files/.profile ~/.profile
