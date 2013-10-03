#!/bin/bash -eu

function backup {
    if [[ -e $1 ]] ; then
        mv $1 $1_$(date +"%F_%H-%M-%S")
    fi
}

cd

backup ~/.vim
backup ~/.vimrc
backup ~/.gvimrc

git clone https://github.com/tojuhaka/vimconfig.git ~/.vim
cd ~/.vim

git submodule init
git submodule update
git submodule foreach git submodule init
git submodule foreach git submodule update

git remote add sshorigin git@github.com:tojuhaka/vimconfig.git
make install
