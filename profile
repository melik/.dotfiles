# MacPorts Installer addition on 2012-01-10_at_04:01:20: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


# Bash Promt Custom http://asemanfar.com/Current-Git-Branch-in-Bash-Prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(git:\1)/'
}
parse_svn_branch() {
    parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print "(svn:"$1 "/" $2 ")"}'
}
parse_svn_url() {
    svn info 2>/dev/null | grep -e '^URL*' | sed -e 's#^URL: *\(.*\)#\1#g '
}
parse_svn_repository_root() {
    svn info 2>/dev/null | grep -e '^Repository Root:*' | sed -e 's#^Repository Root: *\(.*\)#\1\/#g '
}
export PS1="\[\033[1;33m\]\u\[\033[0m\]@\h\[\033[36m\] [\w]\[\033[0m\] \$(parse_git_branch)\$(parse_svn_branch)\[\033[37m\]$\[\033[00m\] "


# Alias
alias ls="ls -GF"
alias ll="ls -lhAGF"
alias top="top -ocpu"
alias sshR="ssh -l username "
alias myIP='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2'