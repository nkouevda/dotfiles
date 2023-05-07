# Location of this file
root := $(shell dirname "$(realpath $(lastword $(MAKEFILE_LIST)))")

# Symlink if `ln=1`; copy otherwise
ifeq ($(ln),1)
  INSTALL := ln -fs
else
  INSTALL := cp -f
endif

targets := bash bat brew ctags dircolors fzf git karabiner kitty readline ripgrep ssh tig tmux vim

.PHONY: all $(targets)

all: $(targets)

bash:
	$(INSTALL) "$(root)"/.bash_profile ~
	$(INSTALL) "$(root)"/.bashrc ~
	touch ~/.hushlogin
	cd "$(root)" \
	  && find .config/bash -type d -exec mkdir -p ~/{} \; \
	  && find .config/bash -type f -exec $(INSTALL) "$(root)"/{} ~/{} \;
	mkdir -p ~/.local/state/bash

bat:
	cd "$(root)" \
	  && find .config/bat -type d -exec mkdir -p ~/{} \; \
	  && find .config/bat -type f -exec $(INSTALL) "$(root)"/{} ~/{} \;

brew:
	brew update
	brew upgrade
	brew install \
	  bash \
	  bash-completion@2 \
	  bat \
	  cabal-install \
	  coreutils \
	  ctags \
	  diffstat \
	  diffutils \
	  exiftool \
	  findutils \
	  fzf \
	  gawk \
	  git \
	  gnu-sed \
	  grep \
	  gron \
	  jq \
	  less \
	  maven \
	  moreutils \
	  nkouevda/nkouevda/capital-gains \
	  nkouevda/nkouevda/estimated-taxes \
	  nkouevda/nkouevda/pdiff \
	  nkouevda/nkouevda/spongecase \
	  node \
	  pdfgrep \
	  pv \
	  python \
	  qlmarkdown \
	  ripgrep \
	  rsync \
	  ruby \
	  sbt \
	  scala \
	  switchaudio-osx \
	  tig \
	  tree \
	  vim \
	  wget
	brew cleanup --prune=all

ctags:
	$(INSTALL) "$(root)"/.ctags ~

dircolors:
	mkdir -p ~/.config
	$(INSTALL) "$(root)"/.config/dircolors ~/.config/dircolors

fzf:
	"$(shell brew --prefix)"/opt/fzf/install --xdg --key-bindings --no-completion --no-update-rc

git:
	mkdir -p ~/.config/git
	$(INSTALL) "$(root)"/.config/git/config ~/.config/git/config
	$(INSTALL) "$(root)"/.config/git/ignore ~/.config/git/ignore

karabiner:
	mkdir -p ~/.config/karabiner
	$(INSTALL) "$(root)"/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json

kitty:
	mkdir -p ~/.config/kitty
	$(INSTALL) "$(root)"/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
	mkdir -p ~/.config/kitty/themes
	$(INSTALL) "$(root)"/.config/kitty/themes/material.conf ~/.config/kitty/themes/material.conf

readline:
	mkdir -p ~/.config/readline
	$(INSTALL) "$(root)"/.config/readline/inputrc ~/.config/readline/inputrc

ripgrep:
	mkdir -p ~/.config/ripgrep
	$(INSTALL) "$(root)"/.config/ripgrep/config ~/.config/ripgrep/config

ssh:
	mkdir -p ~/.ssh
	$(INSTALL) "$(root)"/.ssh/config ~/.ssh/config

tig:
	mkdir -p ~/.config/tig
	$(INSTALL) "$(root)"/.config/tig/config ~/.config/tig/config
	# ~/.local/share/tig/history instead of ~/.tig_history
	mkdir -p ~/.local/share/tig

tmux:
	mkdir -p ~/.config/tmux
	$(INSTALL) "$(root)"/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf

vim:
	cd "$(root)" \
	  && find .vim -type d -exec mkdir -p ~/{} \; \
	  && find .vim -type f -exec $(INSTALL) "$(root)"/{} ~/{} \;
	mkdir -p ~/.vim/autoload
	curl -sSLo ~/.vim/autoload/plug.vim \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	mkdir -p ~/.vim/swap
	vim +PlugInstall +qa
