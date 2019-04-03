export ZSH="/home/vinicius/.oh-my-zsh"
ZSH_THEME="agnoster"
ZSH_TMUX_AUTOSTART="true"

plugins=(
  git
  docker
  history
  web-search
  dnf
  zsh-syntax-highlighting
  #zsh-autosuggestions
  bgnotify
)

source $ZSH/oh-my-zsh.sh

# Letsgrow
export CURRENT_PROJECT_PATH=$HOME/Projects/bitblue
export CURRENT_PROJECT_MAIN_BRANCH='origin/master'

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
alias routes="dc run --rm app php artisan route:list"
alias migrate='dc run --rm app php artisan migrate'
alias tinker='dc run --rm app php artisan tinker'
alias assets_compile='assets_compile_run'
alias artisan='dc run --rm app php artisan'
alias cauto='dc run --rm app composer dumpautoload -o'
alias dcra='dc run app'
alias dcrf='dc run front'
alias queue='dcra php artisan queue:work --queue=email,default,join-email'

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
alias grc='gr --continue'
alias gra='gr --abort'
alias gcm='gc -m'
alias gpcbf='git_push_current_branch_forced'
alias gdb="git_diff_commits_between_branches"

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

# ssh

# tmux
alias tmux.conf='vim ~/.tmux.conf'

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
  base='https://bitbucket.org/letsgrow/bitblue-admin/pull-requests/new?source='
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

da() {
    dc run --rm $1 php artisan $2 $3 $4
}

dm() {
    dc run --rm $1 $2 $3 $4 $5 $6
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

git_diff_commits_between_branches() {
    #git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative $1..$2
    git log --graph --pretty=format:'%h' --no-patch --abbrev-commit --date=relative $1..$2
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
source ~/.rvm/scripts/rvm

# Linux
if [ -d "$HOME/.local/bin"  ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# conectar no psql
#docker run --rm --network bitblue_default -it bitblue_postgres psql -U postgres -h postgres
