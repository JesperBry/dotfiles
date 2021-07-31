parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

NEWLINE=$'\n'
setopt PROMPT_SUBST
PROMPT='%n %9c%{%F{yellow}%}$(parse_git_branch)%{%F{242m}%} ${NEWLINE}$ '

# Add "code ." as command in PATH
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

alias cls=clear
