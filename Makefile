# Location of this file
root := $(shell dirname "$(realpath $(lastword $(MAKEFILE_LIST)))")

# Symlink if `ln=1`; copy otherwise
ifeq ($(ln),1)
  INSTALL := ln -fs
else
  INSTALL := cp -f
endif

targets := bash brew ctags git karabiner kitty python ripgrep ssh tig tmux vim

.PHONY: all $(targets)

all: $(targets)

bash:
	$(INSTALL) "$(root)"/.bash_completion ~
	$(INSTALL) "$(root)"/.bash_functions ~
	$(INSTALL) "$(root)"/.bash_profile ~
	$(INSTALL) "$(root)"/.bashrc ~
	$(INSTALL) "$(root)"/.dircolors ~
	$(INSTALL) "$(root)"/.hushlogin ~
	$(INSTALL) "$(root)"/.inputrc ~

brew:
	brew update
	brew upgrade
	brew install \
	  bash \
	  bash-completion@2 \
	  cabal-install \
	  coreutils \
	  ctags \
	  diffstat \
	  diffutils \
	  findutils \
	  fzf \
	  gawk \
	  git \
	  gnu-sed \
	  go \
	  grep \
	  gron \
	  jq \
	  less \
	  macvim \
	  maven \
	  moreutils \
	  nkouevda/nkouevda/capital-gains \
	  nkouevda/nkouevda/estimated-taxes \
	  nkouevda/nkouevda/pdiff \
	  nkouevda/nkouevda/spongecase \
	  node \
	  openssl@1.1 \
	  pipgrip \
	  pv \
	  python \
	  ripgrep \
	  rsync \
	  ruby \
	  sbt \
	  scala \
	  sourcegraph/src-cli/src-cli \
	  tig \
	  tree \
	  wget
	brew cleanup --prune=0 -s

ctags:
	$(INSTALL) "$(root)"/.ctags ~

git:
	$(INSTALL) "$(root)"/.gitconfig ~
	mkdir -p ~/.config/git
	$(INSTALL) "$(root)"/.config/git/ignore ~/.config/git/ignore

karabiner:
	mkdir -p ~/.config/karabiner
	$(INSTALL) "$(root)"/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json

kitty:
	mkdir -p ~/.config/kitty
	$(INSTALL) "$(root)"/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
	mkdir -p ~/.config/kitty/themes
	$(INSTALL) "$(root)"/.config/kitty/themes/material.conf ~/.config/kitty/themes/material.conf

python:
	$(INSTALL) "$(root)"/.pypirc ~
	$(INSTALL) "$(root)"/.pystartup ~

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
