#!/bin/bash
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export NC='\033[0m'

#echo -e "${RED}Creating symbolik links${NC}"

read -p "We're remove your old dotfiles, are you sure about go on? (Y/N)" -n 1 -r
printf "\n"

if [[ $REPLY =~ ^[Yy]$ ]]
then
  printf "Removing your dotfiles \n"
  rm $HOME/.vimrc 2> /dev/null
  rm -rf $HOME/.vim 2> /dev/null
  #rm $HOME/.zshrc
  
  printf "Creating symbolik links between dotfiles \n"
  
  ln -s $(pwd)/.vimrc $HOME/.vimrc
  ln -s $(pwd)/.vim $HOME/.vim
  #ln -s .zshrc $HOME/.zshrc

 printf "Instaling pluggins manager for vim \n"

  curl ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

 
  printf "Instaling dependencies \n"
  P=$(pwd) 
  sudo apt-get install -y build-essential cmake cmake3 python-dev
  #sudo apt-get install python-dev #python-3-dev
  cd ~/.vim/plugged/YouCompleteMe
  ./install.py
  cd P

  

  printf "Instaling vim pluggins \n"
  vim -e +PlugInstall +q
fi
