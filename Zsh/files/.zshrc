export ZSH=$HOME/.oh-my-zsh
export PATH=$PATH:/opt/homebrew/bin

eval "$(/opt/homebrew/bin/brew shellenv)"

ZSH_THEME="robbyrussell"

plugins=(
    httpie
    urltools
    macports
    ansible
    isodate
    git
    github
    git-flow
    gitignore
    svn
    node
    npm
    gatsby
    pip
    virtualenv
    python
    vagrant
    vagrant-prompt
    docker
    docker-compose
    zsh-autosuggestions
    zsh-syntax-highlighting
    command-not-found
    colored-man-pages
    heroku
)

# Add default user
DEFAULT_USER=melik

source $ZSH/oh-my-zsh.sh
source ~/.aliases
source ~/.functions

# Stop AUTO_CD - Changing Directories
unsetopt AUTO_CD

bindkey -e
bindkey '[C' forward-word
bindkey '[D' backward-word

export PATH=$HOME/.local/bin:$PATH
