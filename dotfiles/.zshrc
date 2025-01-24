source /usr/local/Cellar/antigen/2.2.3/share/antigen/antigen.zsh

autoload -Uz compinit && compinit

PROJECT_DIR=~/Projects

# fzf configs
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf-alias.zsh ] && source ~/.fzf-alias.zsh
bindkey "ç" fzf-cd-widget

# bat configs
[ -f ~/.bat-alias.zsh ] && source ~/.bat-alias.zsh

trash() {
  echo "Moving files to Trash can..."
  mv "$@" "$HOME/.trash"
}

# Add "code ." as command in PATH
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# IPs
getLocalIP() { ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}' }
getPublicIP() { dig +short myip.opendns.com @resolver1.opendns.com }

# Alias
alias cat='bat --paging=never'
alias cls=clear
alias home=cd ~
alias dev='cd ~/Projects'
alias reload='exec zsh'
alias ls='ls -p -G -a'
alias p='target=$(find "$PROJECT_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | fzf --preview "ls -A $PROJECT_DIR/{}"); if [ "$target" != "" ]; then code "$PROJECT_DIR/$target" && cd "$PROJECT_DIR/$target"; fi'
alias pp='target=$(find "$PROJECT_DIR/Private_projects" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | fzf --preview "ls -A $PROJECT_DIR/Private_projects/{}"); if [ "$target" != "" ]; then code "$PROJECT_DIR/Private_projects/$target" && cd "$PROJECT_DIR/Private_projects/$target"; fi'
alias repo='gh repo view --web'
alias ip='echo Local ip: $(getLocalIP) && echo Public ip: $(getPublicIP)'
alias qr='qrencode -m 2 -t utf8 <<< "$1"'
alias preview='qlmanage -px <<< "$1"'

# Add ngrok completions
if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
fi

# Plugins
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

# Tell Antigen that you're done.
antigen apply

# Apply fnm
eval "$(fnm env --use-on-cd --version-file-strategy=recursive  --shell zsh)"

# Apply starship
eval "$(starship init zsh)"