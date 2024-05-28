#!/bin/bash

# Install vim latest
git clone https://github.com/vim/vim --depth==1 && cd ./vim && ./configure && make -j4 && make install

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install vimrc
! [[ -f ~/.vimrc ]] && ln -s $(realpath ./vimrc) ~/.vimrc

