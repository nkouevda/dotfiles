# Location of this file
root := $(shell dirname "$(realpath $(lastword $(MAKEFILE_LIST)))")

# Symlink if `ln=1`; copy otherwise
ifeq ($(ln),1)
  install := ln -fs
else
  install := cp -f
endif

targets := ag bash brew ctags dircolors git hg iterm karabiner python readline ssh tig vim

.PHONY: all $(targets)

all: $(targets)

ag:
	$(install) "$(root)"/.agignore ~

bash:
	$(install) "$(root)"/.bash_completion ~
	$(install) "$(root)"/.bash_functions ~
	$(install) "$(root)"/.bash_profile ~
	$(install) "$(root)"/.bashrc ~
	$(install) "$(root)"/.hushlogin ~

brew:
	brew update
	brew upgrade
	brew install bash
	brew install bash-completion
	brew install boost
	brew install cmake
	brew install coreutils
	brew install ctags
	brew install diffstat
	brew install diffutils
	brew install findutils --with-default-names
	brew install fzf
	brew install gawk
	brew install git
	brew install gnu-sed --with-default-names
	brew install grep --with-default-names
	brew install jq
	brew install less
	brew install macvim --with-python3
	brew install maven
	brew install moreutils
	brew install openssl
	brew install pv
	brew install python
	brew install python3
	brew install ripgrep
	brew install rsync
	brew install s3cmd
	brew install scala
	brew install tig
	brew install tree
	brew install vim --with-python3
	brew install wget
	brew linkapps
	brew cleanup --prune=0 -s
	brew prune

ctags:
	$(install) "$(root)"/.ctags ~

dircolors:
	$(install) "$(root)"/.dircolors ~

git:
	$(install) "$(root)"/.gitconfig ~
	mkdir -p ~/.config/git
	$(install) "$(root)"/.config/git/ignore ~/.config/git/ignore

hg:
	$(install) "$(root)"/.hgrc ~

iterm:
	open "$(root)"/iterm/*.itermcolors

karabiner:
	mkdir -p ~/.config/karabiner
	$(install) "$(root)"/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json

python:
	$(install) "$(root)"/.pypirc ~
	$(install) "$(root)"/.pystartup ~

readline:
	$(install) "$(root)"/.inputrc ~

ssh:
	mkdir -p ~/.ssh
	$(install) "$(root)"/.ssh/config ~/.ssh/config

tig:
	$(install) "$(root)"/.tigrc ~

vim:
	$(install) "$(root)"/.gvimrc ~
	$(install) "$(root)"/.vimrc ~
	cd "$(root)" \
	  && find .vim -type d -exec mkdir -p ~/{} \; \
	  && find .vim -type f -exec $(install) "$(root)"/{} ~/{} \;
	mkdir -p ~/.vim/autoload
	curl -sSLo ~/.vim/autoload/plug.vim \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	mkdir -p ~/.vim/swap
	vim +PlugInstall +qa
