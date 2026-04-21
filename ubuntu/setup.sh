#!/bin/bash
read -p "We'll remove your old vim files, are you sure about go on? (Y/N)" -n 1 -r
printf "\n"

if [[ $REPLY =~ ^[Yy]$ ]]
then
  DOTFILES_PATH=$(pwd)

  printf "Removing your vim files \n"
  rm $HOME/.vimrc 2> /dev/null
  rm -rf $HOME/.vim 2> /dev/null

  printf "Creating symbolik links between vim files \n"

  ln -s DOTFILES_PATH/.vimrc $HOME/.vimrc
  ln -s DOTFILES_PATH/.vim $HOME/.vim

  printf "Instaling pluggins manager for vim \n"

  curl ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  printf "Instaling dependencies \n"

  sudo apt-get install -y build-essential cmake cmake3 python-dev 2> /dev/null
  cd ~/.vim/plugged/YouCompleteMe
  ./install.py
  cd DOTFILES_PATH

  printf "Instaling vim pluggins \n"
  vim -e +PlugInstall +q
fi
