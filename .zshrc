export ZSH="/home/vinicius/.oh-my-zsh"
ZSH_THEME="agnoster"
ZSH_TMUX_AUTOSTART="true"

plugins=(
  git
  docker
  Composer
  history
  web-search
)

source $ZSH/oh-my-zsh.sh

# Letsgrow
export CURRENT_PROJECT_PATH=$HOME/Projects/allie/project
export CURRENT_PROJECT_MAIN_BRANCH='origin/develop'

alias send-pr='send_pull_request'

# My personal configs

export BROWSER=google-chrome
export EDITOR=vim

# Config
alias zshrc='$EDITOR ~/.zshrc && source ~/.zshrc'
alias vimrc='$EDITOR ~/.vimrc'

# Format output
alias pretty_json='json_pp | pygmentize -l json | less'

# Online
alias wiki='$BROWSER http://alonso.pbworks.com'
alias whatsapp='$BROWSER https://web.whatsapp.com'
alias skype='$BROWSER https://web.skype.com'
alias g='google'
alias translate='search_english_word'

# Composer
alias c='composer'
alias ci='c install'
alias cr='c remove'

# Docker
alias dc='docker-compose'
alias rollback='dc run --rm app php artisan migrate:rollback'
alias migrate='dc run --rm app php artisan migrate'
alias tinker='dc run --rm app php artisan tinker'
alias assets_compile='assets_compile_run'
alias artisan='dc run --rm app php artisan'

# Git alias

alias gucb='git_update_current_branch'
alias gpcb='git_push_current_branch'
alias gs='git status'
alias gl='git log'
alias gd='git diff'
alias gk='git checkout'
alias gf='git fetch'
alias gst='git stash'
alias gr='git rebase'
alias gcm='gc -m'
alias gpcbf='git_push_current_branch_forced'

# Laravel alias
alias pa='php artisan'

# Linux commands
alias s='sudo'
alias u='sudo apt-get update'
alias i='sudo apt-get install'
alias p='sudo apt-get purge'
alias v='$EDITOR'
alias stop='stop_services'
alias start='start_services'

# Running tests
alias t='./vendor/bin/phpunit'
alias td='pa dusk'

# Golang
export PATH=$PATH:/usr/local/go/bin

setopt HIST_IGNORE_ALL_DUPS


git_update_current_branch() {
  git pull origin $(git symbolic-ref --short HEAD 2> /dev/null)
}

search_english_word() {
  $BROWSER "https://www.linguee.com.br/portugues-ingles/search?source=auto&query=$1"
}

git_push_current_branch() {
  git push origin $(git symbolic-ref --short HEAD 2> /dev/null)
}

git_push_current_branch_forced() {
  git push origin $(git symbolic-ref --short HEAD 2> /dev/null) -f
}

get_pull_request_url() {
  base='https://bitbucket.org/letsgrow/allie/pull-requests/new?source='
  branch=$(git symbolic-ref --short HEAD 2> /dev/null)
  final="&t=1"
  echo "$base$branch$final"
}

send_pull_request() {
  gf
  gr $CURRENT_PROJECT_MAIN_BRANCH
  gpcb
  $BROWSER $(get_pull_request_url)
}

send_pull_request_release() {
  old_branch = $(git symbolic-ref --short HEAD 2> /dev/null)

  gk release-candidate
  # gucb
  gk old_branch
  # git merge release-candidate
  # gpcb
  # $BROWSER $(get_pull_request_url)
}
stop_services() {
  s service postgresql stop && \
  s service redis-server stop &&
  show_notify "Serviços pausados" "O postgresql e o redis foram pausados"
}

start_services() {
  s service postgresql start && \
  s service redis-server start &&
  show_notify "Serviços iniciados" "O postgresql e o redis foram iniciados"
}

assets_compile_run() {
  dc run --rm front npm run dev
  show_notify "Assets compilados!" "Seus arquivos estáticos foram compilados com sucesso"
}

hot() {
    dc run --rm front npm run hot
}

clear_cache() {
  dc run --rm app php artisan upgrade --dev
  show_notify "Cache limpo" "O cache do container app está limpo"
}

show_task() {
    $BROWSER "https://letsgrow.atlassian.net/browse/ALLIE-$1"
}

show_notify() {
  notify-send -i ~/Downloads/lets.png $1 $2
}
