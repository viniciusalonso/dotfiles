ZSH_THEME="robbyrussell"

plugins=(
  git
)

# Scripts

git_update_current_branch() {
  git pull origin $(git symbolic-ref --short HEAD 2> /dev/null)
}

source $ZSH/oh-my-zsh.sh

# My personal configs

export BROWSER=google-chrome
export EDITOR=vim

# Config
alias zshconfig='$EDITOR ~/.zshrc && source ~/.zshrc'
alias vimconfig='$EDITOR ~/.vimrc'

# Online
alias wiki='$BROWSER http://alonso.pbworks.com'
alias whatsapp='$BROWSER https://web.whatsapp.com'
alias skype='$BROWSER https://web.skype.com'
alias g='googler'

# Git alias

alias gucb='git_update_current_branch'

setopt HIST_IGNORE_ALL_DUPS

