# Symlink if LN=1; copy otherwise
ifeq ($(LN),1)
  COPY := ln -fsv
else
  COPY := cp -fv
endif

# Location of this file
ROOT := $(shell dirname "$(realpath $(lastword $(MAKEFILE_LIST)))")

# All targets except all
TARGETS := ag bash brew dircolors git hg iterm karabiner python readline tig vim

# Phony targets
.PHONY: all $(TARGETS)

all: $(TARGETS)

ag:
	$(COPY) "$(ROOT)"/.agignore ~

bash:
	$(COPY) "$(ROOT)"/.bash_functions ~
	$(COPY) "$(ROOT)"/.bash_profile ~
	$(COPY) "$(ROOT)"/.bashrc ~

brew:
	brew tap homebrew/dupes
	brew update
	brew upgrade --all
	brew install bash
	brew install bash-completion
	brew install coreutils
	brew install ctags
	brew install diffstat
	brew install diffutils
	brew install ed --default-names
	brew install findutils --with-default-names
	brew install fzf
	brew install gawk
	brew install git
	brew install gnu-sed --with-default-names
	brew install grep --with-default-names
	brew install gzip
	brew install htop
	brew install less
	brew install macvim
	brew install moreutils
	brew install openssl
	brew install python
	brew install python3
	brew install rsync
	brew install the_silver_searcher
	brew install tig --with-docs
	brew install tree
	brew install vim
	brew install wget
	brew link --force openssl
	brew linkapps
	brew cleanup -s
	brew prune

dircolors:
	$(COPY) "$(ROOT)"/.dircolors ~

git:
	$(COPY) "$(ROOT)"/.gitconfig ~
	mkdir -pv ~/.config/git
	$(COPY) "$(ROOT)"/.config/git/ignore ~/.config/git/

hg:
	$(COPY) "$(ROOT)"/.hgrc ~

iterm:
	open "$(ROOT)"/iterm/*.itermcolors

karabiner:
	$(COPY) "$(ROOT)"/karabiner/private.xml \
	  ~/Library/Application\ Support/Karabiner/

python:
	$(COPY) "$(ROOT)"/.pystartup ~

readline:
	$(COPY) "$(ROOT)"/.inputrc ~

tig:
	$(COPY) "$(ROOT)"/.tigrc ~

vim:
	$(COPY) "$(ROOT)"/.gvimrc "$(ROOT)"/.vimrc  ~
	cd "$(ROOT)"; find .vim -type d -exec mkdir -pv ~/{} \;
	cd "$(ROOT)"; find .vim -type f -exec $(COPY) "$(ROOT)"/{} ~/{} \;
	mkdir -pv ~/.vim/autoload ~/.vim/tmp/swap
	curl -sSLo ~/.vim/autoload/plug.vim \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall +qa
