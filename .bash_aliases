# ~/.bash_aliases

# ─── Navigation ───────────────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias projects='cd $PROJECTS'             # jump to projects directory
alias c='clear'
alias mk='mkdir -p'                 # create nested directories in one command

# ─── ls ───────────────────────────────────────────────────────────────────────
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -alFh --group-directories-first'   # long list, human readable sizes
alias la='ls -A'                                 # show hidden files
alias l='ls -CF'                                 # compact columnar view
alias lt='ls -alFht'                             # sorted by modified time
alias lsize='ls -lSrh'                           # sorted by size

# ─── Safety nets ──────────────────────────────────────────────────────────────
alias rm='rm -i'    # prompt before deleting
alias cp='cp -i'    # prompt before overwriting
alias mv='mv -i'    # prompt before overwriting

# ─── System info ──────────────────────────────────────────────────────────────
alias df='df -h'        # disk usage in human readable format
alias du='du -h'        # directory sizes in human readable format
alias free='free -h'    # memory usage in human readable format
alias ports='ss -tulnp' # show all listening ports

# ─── Colors ───────────────────────────────────────────────────────────────────
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ─── Git ──────────────────────────────────────────────────────────────────────
alias gs='git status -sb'           # short status with branch info
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpf='git push --force-with-lease'  # safer than --force
alias gpl='git pull --rebase'       # avoids unnecessary merge commits
alias gd='git diff'
alias gds='git diff --staged'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gsw='git switch'              # modern alternative to checkout
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# ─── Docker ───────────────────────────────────────────────────────────────────
alias docker-start='sudo service docker start'  # start daemon when needed
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dimg='docker images'
alias dex='docker exec -it'
alias dlog='docker logs -f'
alias dclean='docker system prune -f'           # remove unused containers/images
alias dc='docker compose'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcl='docker compose logs -f'

# ─── Node / npm ───────────────────────────────────────────────────────────────
alias ni='npm install'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias nr='npm run'
alias nrd='npm run dev'
alias nrb='npm run build'
alias nrt='npm run test'

# ─── pnpm ─────────────────────────────────────────────────────────────────────
alias p='pnpm'
alias pi='pnpm install'
alias pd='pnpm dev'
alias pb='pnpm build'
alias pt='pnpm test'

# ─── WSL utilities ────────────────────────────────────────────────────────────
alias explorer='explorer.exe .'         # open Windows Explorer in current directory
alias code='code .'                     # open VS Code in current directory
alias winhome='cd /mnt/c/Users/arekz'  # jump to Windows home directory
alias clip='clip.exe'                   # pipe output to Windows clipboard

# ─── Config shortcuts ─────────────────────────────────────────────────────────
alias conf-bash='code ~/projects/configs/.bashrc'
alias conf-alias='code ~/projects/configs/.bash_aliases'
alias conf-git='code ~/projects/configs/.gitconfig_shared'
alias ea='code ~/.bash_aliases && reload'   # edit aliases and reload immediately

# ─── Misc ─────────────────────────────────────────────────────────────────────
alias ff='find . -type f -name'         # usage: ff "*.js"
alias fd='find . -type d -name'         # usage: fd "src"
alias myip='curl -s ifconfig.me'        # your public IP
alias path='echo -e ${PATH//:/\\n}'     # print PATH one entry per line
alias reload='source ~/.bashrc'         # reload config without restarting terminal
alias aliases='cat ~/.bash_aliases'     # quickly view this file
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'