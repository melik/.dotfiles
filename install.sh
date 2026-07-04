source const.sh

# git pull origin master;

# cd "$(dirname "${BASH_SOURCE}")";

# Update Bash
prompt_and_do "Bash" "Bash configs"

# Install Brew and some software with it
prompt_and_do "Brew" "Brew" "install"

# Update Zsh
prompt_and_do "Zsh" "Zsh configs"

# Update Git
prompt_and_do "Git" "Git"

# Update Mac Defaults
prompt_and_do "Mac" "Defaults"

# Update iTerm2
prompt_and_do "iTerm" "iTerm"
