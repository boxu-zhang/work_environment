#!/bin/bash

# Install dircolors
! [[ -f ~/.dircolors ]] && ln -s $(realpath ./dircolors) ~/.dircolors

# Install vimrc
! [[ -f ~/.vimrc ]] && ln -s $(realpath ./vimrc) ~/.vimrc

# Install cmakelists tpl
! [[ -f ~/.CMakeLists.txt.tpl ]] && ln -s $(realpath ./CMakeLists.txt.tpl) ~/.CMakeLists.txt.tpl

# Install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
