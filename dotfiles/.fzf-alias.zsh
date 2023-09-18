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

# Change branch (latest first)
gb() {
    local branches branch
    branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
    branch=$(echo "$branches" |
             fzf --height 40% -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

gbd() {
  git branch | fzf | awk '{print $1}' | xargs git branch -d
}

# git log show with fzf
gl() {

  # param validation
  if [[ ! `git log -n 1 $@ | head -n 1` ]] ;then
    return
  fi

  # filter by file string
  local filter
  # param existed, git log for file if existed
  if [ -n $@ ] && [ -f $@ ]; then
    filter="-- $@"
  fi

  # git command
  local gitlog=(
    git log
    --graph --color=always
    --abbrev=7
    --format='%C(auto)%h %an %C(blue)%s %C(yellow)%cr'
    $@
  )

  # fzf command
  local fzf=(
    fzf
    --ansi --no-sort --reverse --tiebreak=index
    --preview "f() { set -- \$(echo -- \$@ | grep -o '[a-f0-9]\{7\}'); [ \$# -eq 0 ] || git show --color=always \$1 $filter; }; f {}"
    --bind "ctrl-q:abort,ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % $filter | less -R') << 'FZF-EOF'
                {}
                FZF-EOF"
   --preview-window=right:60%
  )

  # piping them
  $gitlog | $fzf
}

# ---- GitHub -----

# find and view gh gists
gist() {
  gh gist list | fzf | awk '{print $1}' | xargs gh gist view
}