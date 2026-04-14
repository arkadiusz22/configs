# ~/.bashrc
# Symlinked: ~/.bashrc -> ~/projects/configs/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ─── Environment Variables ────────────────────────────────────────────────────
# Use VS Code as the default editor for git commits and other CLI tools
export EDITOR='code --wait'
export VISUAL='code --wait'
export PROJECTS="$HOME/projects"
export GPG_TTY=$(tty)
export BROWSER="wslview" # WSL: open URLs in Windows default browser
export PATH="$HOME/.local/bin:$PATH" # Local user binaries

# Ensure projects directory exists
[ ! -d "$PROJECTS" ] && mkdir -p "$PROJECTS"

# ─── History Configuration ───────────────────────────────────────────────────
# Ignore duplicate commands; erasedups keeps the history clean
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=20000
HISTIGNORE="ls:ll:cd:pwd:clear:c" # Skip saving trivial commands to history
# Append to the history file, don't overwrite it
shopt -s histappend
# Immediate history sync across multiple terminal sessions
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }history -a; history -c; history -r"

# ─── Shell Options ────────────────────────────────────────────────────────────
# Check window size after each command and update LINES and COLUMNS
shopt -s checkwinsize
# Allow recursive globbing (e.g., ls **/file.txt)
shopt -s globstar
# Change directory just by typing the name
shopt -s autocd
# Correct minor spelling errors in cd commands
shopt -s cdspell

# ─── Chroot label ─────────────────────────────────────────────────────────────
# Populates $debian_chroot used in the prompt below
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# ─── Color support ────────────────────────────────────────────────────────────
# Enables colored output for ls — picked up by aliases in ~/.bash_aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# ─── Prompt Configuration ─────────────────────────────────────────────────────
# Extract current git branch name for the prompt
parse_git_branch() {
    git branch 2>/dev/null | grep '^*' | sed 's/* //'
}

# Always use colored prompt — tput is always available on Ubuntu
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00;33m\]$(b=$(parse_git_branch); [ -n "$b" ] && echo " ($b)")\[\033[00m\]\$ '

# Set terminal window title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
esac

# ─── GPG and SSH Agents ───────────────────────────────────────────────────────
# Start GPG agent for signed commits
if ! pgrep -x -u "$USER" gpg-agent >/dev/null; then
    gpg-connect-agent /bye >/dev/null 2>&1
fi

# Start SSH agent and add your private key for GitHub authentication
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi

# ─── Tools and Completions ────────────────────────────────────────────────────
# Makes less handle binary/non-text input files gracefully
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable tab-completion for git, docker, npm and other tools
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# ─── Node Version Manager (nvm) ───────────────────────────────────────────────
# Load nvm and its bash completion for switching Node.js versions per project
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ─── pnpm ─────────────────────────────────────────────────────────────────────
# Add pnpm global bin directory to PATH
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ─── Aliases ──────────────────────────────────────────────────────────────────
# Load custom aliases from a separate file to keep this config clean
if [ -f ~/projects/configs/.bash_aliases ]; then
    . ~/projects/configs/.bash_aliases
fi

# ─── Secrets (Local Only) ─────────────────────────────────────────────────────
if [ -f ~/.bash_secrets ]; then
    . ~/.bash_secrets
fi