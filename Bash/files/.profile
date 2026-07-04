parse_git_branch () {
    if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then git branch | sed -n '/\* /s///p'; fi  | awk '{print " ["$1"]" }'
}
parse_svn_branch() {
    parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk '{print " ["$1"]" }'
}
parse_svn_url() {
    svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}
parse_svn_repository_root() {
    svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}

BLACK="\[\033[0;38m\]"
RED="\[\033[0;31m\]"
RED_BOLD="\[\033[01;31m\]"
BLUE="\[\033[01;34m\]"
GREEN="\[\033[0;32m\]"

export PS1="$GREEN\u@$GREEN\h:$BLUE\w$RED_BOLD\$(parse_git_branch)\$(parse_svn_branch)$BLACK$ "
