# Location of this file
root := $(shell dirname "$(realpath $(lastword $(MAKEFILE_LIST)))")

# Symlink if `ln=1`; copy otherwise
ifeq ($(ln),1)
  INSTALL := ln -fs
else
  INSTALL := cp -f
endif

targets := bash brew ctags dircolors git hg karabiner kitty python readline ripgrep ssh tig tmux vim

.PHONY: all $(targets)

all: $(targets)

bash:
	$(INSTALL) "$(root)"/.bash_completion ~
	$(INSTALL) "$(root)"/.bash_functions ~
	$(INSTALL) "$(root)"/.bash_profile ~
	$(INSTALL) "$(root)"/.bashrc ~
	$(INSTALL) "$(root)"/.hushlogin ~

brew:
	brew update
	brew upgrade
	brew install bash
	brew install bash-completion2
	brew install coreutils
	brew install ctags
	brew install diffstat
	brew install diffutils
	brew install findutils
	brew install fzf
	brew install gawk
	brew install git
	brew install gnu-sed
	brew install go
	brew install grep
	brew install jq
	brew install less
	brew install macvim
	brew install maven
	brew install moreutils
	brew install openssl
	brew install pv
	brew install python
	brew install ripgrep
	brew install rsync
	brew install s3cmd
	brew install scala
	brew install sourcegraph/src-cli/src-cli
	brew install tig
	brew install tree
	brew install wget
	brew cleanup --prune=0 -s

ctags:
	$(INSTALL) "$(root)"/.ctags ~

dircolors:
	$(INSTALL) "$(root)"/.dircolors ~

git:
	$(INSTALL) "$(root)"/.gitconfig ~
	mkdir -p ~/.config/git
	$(INSTALL) "$(root)"/.config/git/ignore ~/.config/git/ignore

hg:
	$(INSTALL) "$(root)"/.hgrc ~

karabiner:
	mkdir -p ~/.config/karabiner
	$(INSTALL) "$(root)"/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json

kitty:
	mkdir -p ~/.config/kitty
	$(INSTALL) "$(root)"/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf

python:
	$(INSTALL) "$(root)"/.pypirc ~
	$(INSTALL) "$(root)"/.pystartup ~

readline:
	$(INSTALL) "$(root)"/.inputrc ~

ripgrep:
	$(INSTALL) "$(root)"/.ripgreprc ~

ssh:
	mkdir -p ~/.ssh
	$(INSTALL) "$(root)"/.ssh/config ~/.ssh/config

tig:
	$(INSTALL) "$(root)"/.tigrc ~

tmux:
	$(INSTALL) "$(root)"/.tmux.conf ~

vim:
	$(INSTALL) "$(root)"/.gvimrc ~
	$(INSTALL) "$(root)"/.vimrc ~
	cd "$(root)" \
	  && find .vim -type d -exec mkdir -p ~/{} \; \
	  && find .vim -type f -exec $(INSTALL) "$(root)"/{} ~/{} \;
	mkdir -p ~/.vim/autoload
	curl -sSLo ~/.vim/autoload/plug.vim \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	mkdir -p ~/.vim/swap
	vim +PlugInstall +qa
