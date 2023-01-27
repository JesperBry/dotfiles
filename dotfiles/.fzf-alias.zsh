RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# ---- Docker -----

# Stop/Start given containers
dcs() {
  if [ $1 = "start" ]; then
      docker ps -a | sed '1d' | fzf -m | awk '{print $1}' | xargs docker start
  elif [ $1 = "stop" ]; then
      docker ps -a | sed '1d' | fzf -m | awk '{print $1}' | xargs docker stop
  else
     echo "\nMissing argument: ${RED}start${NC} or ${RED}stop${NC}"
  fi
}

# Log given container
dcl() {
  docker ps -a | sed '1d' | fzf | awk '{print $1}' | xargs docker logs
}

# Inspect given container
dci() {
  docker ps -a | sed '1d' | fzf | awk '{print $1}' | xargs docker inspect
}

# Remove given containers
dcrm() {
  docker ps -a | sed '1d' | fzf -m | awk '{print $1}' | xargs docker rm
}