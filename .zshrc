ZSH_THEME="robbyrussell"

plugins=(
  git
)

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

setopt HIST_IGNORE_ALL_DUPS

