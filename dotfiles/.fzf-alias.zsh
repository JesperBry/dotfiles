RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# ---- fzf -----
export FZF_DEFAULT_COMMAND='find . \( -name node_modules -o -name .git -o -name .vscode \) -prune -o -print'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --no-height --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# ---- Docker -----

# Stop/Start given containers
dcs() {
  if [ $1 = "start" ]; then
      docker ps -a | sed '1d' | fzf -m --height 40% | awk '{print $1}' | xargs docker start
  elif [ $1 = "stop" ]; then
      docker ps -a | sed '1d' | fzf -m --height 40% | awk '{print $1}' | xargs docker stop
  else
     echo "\nMissing argument: ${RED}start${NC} or ${RED}stop${NC}"
  fi
}

# Log given container
dcl() {
  docker ps -a | sed '1d' | fzf --height 40% | awk '{print $1}' | xargs docker logs --follow
}

# Inspect given container
dci() {
  docker ps -a | sed '1d' | fzf --height 40% | awk '{print $1}' | xargs docker inspect
}

# Remove given containers
dcrm() {
  docker ps -a | sed '1d' | fzf -m --height 40% | awk '{print $1}' | xargs docker rm
}

# ---- Git -----

# Change branch
gb() {
  git branch | fzf --height 40% | awk '{print $1}' | xargs git checkout
}