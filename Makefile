# Nikita Kouevda
# 2015/03/19

# Link if LN=1; copy otherwise
ifeq ($(LN),1)
  CMD := ln -fsv
else
  CMD := cp -fv
endif

# Location of this file
ROOT := $(shell dirname "$(realpath $(lastword $(MAKEFILE_LIST)))")

# All targets except all
TARGETS := ag bash brew git hg iterm python ranger readline tig vim

# Phony targets
.PHONY: all $(TARGETS)

all: $(TARGETS)

ag:
	$(CMD) "$(ROOT)"/.agignore ~

bash:
	$(CMD) "$(ROOT)"/.bash_profile ~
	$(CMD) "$(ROOT)"/.bashrc ~

brew:
	brew tap homebrew/dupes
	brew update
	brew upgrade
	brew install bash
	brew install bash-completion
	brew install coreutils
	brew install ctags
	brew install diffstat
	brew install diffutils
	brew install ed --default-names
	brew install findutils --with-default-names
	brew install flac
	brew install fzf
	brew install gawk
	brew install gdb
	brew install git
	brew install gnu-sed --with-default-names
	brew install grep --with-default-names
	brew install gzip
	brew install lame
	brew install less
	brew install macvim
	brew install mercurial
	brew install nmap
	brew install node
	brew install openssl
	brew install pv
	brew install python
	brew install python3
	brew install ranger
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

git:
	$(CMD) "$(ROOT)"/.gitconfig ~
	mkdir -pv ~/.config/git
	$(CMD) "$(ROOT)"/.config/git/ignore ~/.config/git/ignore

hg:
	$(CMD) "$(ROOT)"/.hgrc ~

iterm:
	open "$(ROOT)"/iterm/*.itermcolors

python:
	$(CMD) "$(ROOT)"/.pystartup ~

ranger:
	mkdir -pv ~/.config/ranger
	$(CMD) "$(ROOT)"/.config/ranger/rc.conf ~/.config/ranger/rc.conf

readline:
	$(CMD) "$(ROOT)"/.inputrc ~

tig:
	$(CMD) "$(ROOT)"/.tigrc ~

vim:
	$(CMD) "$(ROOT)"/.gvimrc "$(ROOT)"/.vimrc  ~
	cd "$(ROOT)"; find .vim -type d -exec mkdir -pv ~/{} \;
	cd "$(ROOT)"; find .vim -type f -exec $(CMD) "$(ROOT)"/{} ~/{} \;
	mkdir -pv ~/.vim/autoload ~/.vim/tmp/swap
	curl -sSLo ~/.vim/autoload/plug.vim \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall +qa
