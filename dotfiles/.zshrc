source /usr/local/Cellar/antigen/2.2.3/share/antigen/antigen.zsh

PROJECT_DIR=~/projects

# fzf configs
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf-alias.zsh ] && source ~/.fzf-alias.zsh
bindkey "ç" fzf-cd-widget

# bat configs
[ -f ~/.bat-alias.zsh ] && source ~/.bat-alias.zsh

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

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

alias cat='bat --paging=never'
alias cls=clear
alias home=cd ~
alias reload='exec zsh'
alias ls='ls -p -G'
alias p='target=$(find "$PROJECT_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | fzf --preview "ls -A $PROJECT_DIR/{}"); if [ "$target" != "" ]; then code "$PROJECT_DIR/$target" && cd "$PROJECT_DIR/$target"; fi'

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    nvm use default --silent
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Plugins
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

# Tell Antigen that you're done.
antigen apply

# Apply starship
eval "$(starship init zsh)"
