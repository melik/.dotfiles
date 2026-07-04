source config.sh

echo "${blue}Update Bash${reset}";

if [ -e ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc_old
fi

rsync --exclude ".git/" --exclude ".DS_Store" -avh --no-perms ./Bash/files/* ~;
