all: update install

.PHONY install: vimrc
	chmod -v +x ~/.vim/bin/*
	ln -fvs ~/.vim/vimrc ~/.vimrc
	~/.vim/bin/buildcommandt
	vim -c 'call pathogen#helptags()' -c 'qa!'
	vim -version || exit 0

.PHONY colors:
	ln -fvs ~/.vim/Xresources ~/.Xresources
	xrdb -merge ~/.Xresources
	~/.vim/bin/set_light.sh

.PHONY friends:
	ln -fvs ~/.vim/others/bashrc ~/.bashrc
	ln -fvs ~/.vim/others/tmux.conf ~/.tmux.conf
	ln -fvs ~/.vim/others/gitconfig ~/.gitconfig
	ln -fvs ~/.vim/others/hgrc ~/.hgrc

.PHONY update:
	git pull
