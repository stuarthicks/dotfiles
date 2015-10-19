#!/bin/bash
set -u

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

link () {
  FILE="$1"
  ln -s "$DIR/$FILE" "$HOME/.$FILE"
}

cd

mv .zshrc .zshrc.bak
mv .vimrc .vimrc.bak

link "abcde.conf"
link "ackrc"
link "aliases"
link "compton.conf"
link "functions"
link "pentadactyl"
link "pentadactylrc"
link "rubocop.yml"
link "tmux.conf"
link "vimrc"
link "xinitrc"
link "xmodmap"
link "xresources"
link "zshenv"
link "zshrc"

touch $HOME/.path
touch $HOME/.zprofile

if git --help &>/dev/null; then
  # For ZSH plugin loading
  curl -sL https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh > ~/.antigen.zsh

  # For VIM plugin loading
  mkdir -p ~/.vim/autoload
  curl -fsLo ~/.vim/autoload/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +"PlugInstall" +qall

  # Tmux Plugin Manager
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  ln -s "$DIR/bin" "$HOME/bin"
  ln -s "$DIR/ftplugin" "$HOME/.vim/ftplugin"
  ln -s "$DIR/git/gitconfig" "$HOME/.gitconfig"
  ln -s "$DIR/git/gitignore" "$HOME/.gitignore"
fi


