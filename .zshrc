ZSH_THEME="geoffgarside"
ZSH_TMUX_AUTOSTART="true"

plugins=(
  git
  docker
  Composer
  history
  tmux
)

# Scripts

git_update_current_branch() {
  git pull origin $(git symbolic-ref --short HEAD 2> /dev/null)
}

search_english_word() {
  $BROWSER "https://www.linguee.com.br/portugues-ingles/search?source=auto&query=$1"
}

git_push_current_branch() {
  git push origin $(git symbolic-ref --short HEAD 2> /dev/null)
}


source $ZSH/oh-my-zsh.sh

# My personal configs

export BROWSER=google-chrome
export EDITOR=vim

# Config
alias zshrc='$EDITOR ~/.zshrc && source ~/.zshrc'
alias vimrc='$EDITOR ~/.vimrc'

# Format output
alias pretty_json='json_pp | less'

# Online
alias wiki='$BROWSER http://alonso.pbworks.com'
alias whatsapp='$BROWSER https://web.whatsapp.com'
alias skype='$BROWSER https://web.skype.com'
alias g='googler'
alias translate='search_english_word'

# Git alias

alias gucb='git_update_current_branch'
alias gpcb='git_push_current_branch'
alias gs='git status'
alias gl='git log'
alias gd='git diff'

# Running tests
alias t='./vendor/bin/phpunit'

setopt HIST_IGNORE_ALL_DUPS

