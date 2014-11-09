# Nikita Kouevda
# 2014/11/09

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
	brew install openssl
	brew link --force openssl
	brew install git mercurial tig
	brew install bash bash-completion
	brew install coreutils diffutils gawk
	brew install findutils --default-names
	brew install gnu-sed --default-names
	brew install grep --default-names
	brew install fzf the_silver_searcher
	brew install ctags macvim vim
	brew install node python python3
	brew install ranger tree
	brew install nmap wget
	brew install flac lame
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
