base_dir := $(shell dirname "$(realpath $(lastword $(MAKEFILE_LIST)))")

# Symlink if `ln=1`; copy otherwise
ifeq ($(ln),1)
  INSTALL := ln -fs
else
  INSTALL := cp -f
endif

targets := bash bat brew ctags curl dig dircolors fzf git karabiner kitty readline ripgrep ssh tig tmux vim

.PHONY: all $(targets)

all: $(targets)

bash:
	$(INSTALL) "$(base_dir)"/.bash_profile ~
	$(INSTALL) "$(base_dir)"/.bashrc ~
	touch ~/.hushlogin
	cd "$(base_dir)" \
	  && find .config/bash -type d -exec mkdir -p ~/{} \; \
	  && find .config/bash -type f -exec $(INSTALL) "$(base_dir)"/{} ~/{} \;
	mkdir -p ~/.local/state/bash

bat:
	cd "$(base_dir)" \
	  && find .config/bat -type d -exec mkdir -p ~/{} \; \
	  && find .config/bat -type f -exec $(INSTALL) "$(base_dir)"/{} ~/{} \;

brew:
	brew update
	brew upgrade
	brew install \
	  bash \
	  bash-completion@2 \
	  bat \
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
	# Does not support XDG_CONFIG_HOME
	$(INSTALL) "$(base_dir)"/.ctags ~/.ctags

curl:
	mkdir -p ~/.config
	$(INSTALL) "$(base_dir)"/.config/.curlrc ~/.config/.curlrc

dig:
	# Does not support XDG_CONFIG_HOME
	$(INSTALL) "$(base_dir)"/.digrc ~/.digrc

dircolors:
	mkdir -p ~/.config
	$(INSTALL) "$(base_dir)"/.config/dircolors ~/.config/dircolors

fzf:
	"$(shell brew --prefix)"/opt/fzf/install --xdg --key-bindings --no-completion --no-update-rc
	mkdir -p ~/.config/fzf
	curl -fLSso ~/.config/fzf/fzf-git.sh \
	  https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh

git:
	mkdir -p ~/.config/git
	$(INSTALL) "$(base_dir)"/.config/git/config ~/.config/git/config
	$(INSTALL) "$(base_dir)"/.config/git/ignore ~/.config/git/ignore

karabiner:
	mkdir -p ~/.config/karabiner
	$(INSTALL) "$(base_dir)"/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json

kitty:
	mkdir -p ~/.config/kitty
	$(INSTALL) "$(base_dir)"/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
	mkdir -p ~/.config/kitty/themes
	$(INSTALL) "$(base_dir)"/.config/kitty/themes/material.conf ~/.config/kitty/themes/material.conf

readline:
	mkdir -p ~/.config/readline
	$(INSTALL) "$(base_dir)"/.config/readline/inputrc ~/.config/readline/inputrc

ripgrep:
	mkdir -p ~/.config/ripgrep
	$(INSTALL) "$(base_dir)"/.config/ripgrep/config ~/.config/ripgrep/config

ssh:
	mkdir -p ~/.ssh
	$(INSTALL) "$(base_dir)"/.ssh/config ~/.ssh/config

tig:
	mkdir -p ~/.config/tig
	$(INSTALL) "$(base_dir)"/.config/tig/config ~/.config/tig/config
	# ~/.local/share/tig/history instead of ~/.tig_history
	mkdir -p ~/.local/share/tig

tmux:
	mkdir -p ~/.config/tmux
	$(INSTALL) "$(base_dir)"/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf

vim:
	cd "$(base_dir)" \
	  && find .vim -type d -exec mkdir -p ~/{} \; \
	  && find .vim -type f -exec $(INSTALL) "$(base_dir)"/{} ~/{} \;
	mkdir -p ~/.vim/autoload
	curl -fLSso ~/.vim/autoload/plug.vim \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	mkdir -p ~/.vim/swap
	vim +PlugInstall +qa
