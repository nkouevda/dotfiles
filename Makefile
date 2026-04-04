base_dir := $(shell dirname "$(realpath $(lastword $(MAKEFILE_LIST)))")

# Copy if `cp=1`; symlink by default
ifeq ($(cp),1)
  INSTALL := cp -f
else
  INSTALL := ln -fs
endif

.PHONY: all
all: 
	@echo error: no targets specified
	@exit 1

.PHONY: bash
bash:
	$(INSTALL) "$(base_dir)"/.bash_profile ~
	$(INSTALL) "$(base_dir)"/.bashrc ~
	touch ~/.hushlogin
	cd "$(base_dir)" \
	  && find .config/bash -type d -exec mkdir -p ~/{} \; \
	  && find .config/bash -type f -exec $(INSTALL) "$(base_dir)"/{} ~/{} \;
	mkdir -p ~/.local/state/bash

.PHONY: bat
bat:
	cd "$(base_dir)" \
	  && find .config/bat -type d -exec mkdir -p ~/{} \; \
	  && find .config/bat -type f -exec $(INSTALL) "$(base_dir)"/{} ~/{} \;

.PHONY: brew
brew:
	brew update
	brew upgrade
	brew install \
	  bash \
	  bash-completion@2 \
	  bat \
	  coreutils \
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
	  shellcheck \
	  switchaudio-osx \
	  tig \
	  tree \
	  universal-ctags \
	  vim \
	  wget
	brew cleanup --prune=all

.PHONY: ctags
ctags:
	mkdir -p ~/.config/ctags
	$(INSTALL) "$(base_dir)"/.config/ctags/config.ctags ~/.config/ctags/config.ctags

.PHONY: curl
curl:
	mkdir -p ~/.config
	$(INSTALL) "$(base_dir)"/.config/.curlrc ~/.config/.curlrc

.PHONY: dig
dig:
	# Does not support XDG_CONFIG_HOME
	$(INSTALL) "$(base_dir)"/.digrc ~/.digrc

.PHONY: dircolors
dircolors:
	mkdir -p ~/.config
	$(INSTALL) "$(base_dir)"/.config/dircolors ~/.config/dircolors

.PHONY: fzf
fzf:
	"$(shell brew --prefix)"/opt/fzf/install --xdg --key-bindings --no-completion --no-update-rc
	mkdir -p ~/.config/fzf
	curl -fLSso ~/.config/fzf/fzf-git.sh \
	  https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh

.PHONY: git
git:
	mkdir -p ~/.config/git
	$(INSTALL) "$(base_dir)"/.config/git/config ~/.config/git/config
	$(INSTALL) "$(base_dir)"/.config/git/ignore ~/.config/git/ignore

.PHONY: karabiner
karabiner:
	mkdir -p ~/.config/karabiner
	$(INSTALL) "$(base_dir)"/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json

.PHONY: kitty
kitty:
	mkdir -p ~/.config/kitty
	$(INSTALL) "$(base_dir)"/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
	mkdir -p ~/.config/kitty/themes
	$(INSTALL) "$(base_dir)"/.config/kitty/themes/material.conf ~/.config/kitty/themes/material.conf

.PHONY: less
less:
	mkdir -p ~/.local/state/less

.PHONY: readline
readline:
	mkdir -p ~/.config/readline
	$(INSTALL) "$(base_dir)"/.config/readline/inputrc ~/.config/readline/inputrc

.PHONY: ripgrep
ripgrep:
	mkdir -p ~/.config/ripgrep
	$(INSTALL) "$(base_dir)"/.config/ripgrep/config ~/.config/ripgrep/config

.PHONY: ssh
ssh:
	mkdir -p ~/.ssh
	$(INSTALL) "$(base_dir)"/.ssh/config ~/.ssh/config

.PHONY: tig
tig:
	mkdir -p ~/.config/tig
	$(INSTALL) "$(base_dir)"/.config/tig/config ~/.config/tig/config
	# Unfortunately tig uses XDG_DATA_HOME instead of XDG_STATE_HOME; still better than ~/.tig_history
	mkdir -p ~/.local/share/tig

.PHONY: tmux
tmux:
	mkdir -p ~/.config/tmux
	$(INSTALL) "$(base_dir)"/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf

.PHONY: vim
vim:
	cd "$(base_dir)" \
	  && find .vim -type d -exec mkdir -p ~/{} \; \
	  && find .vim -type f -exec $(INSTALL) "$(base_dir)"/{} ~/{} \;
	mkdir -p ~/.vim/autoload
	curl -fLSso ~/.vim/autoload/plug.vim \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	mkdir -p ~/.vim/swap
	vim -c PlugInstall -c qa
