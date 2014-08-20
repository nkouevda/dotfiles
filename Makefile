# Nikita Kouevda
# 2014/08/20

# Link if LN=1; copy otherwise
ifeq ($(LN),1)
  CMD := ln -fsv
else
  CMD := cp -fv
endif

# Location of this file
ROOT := $(shell dirname "$(realpath $(lastword $(MAKEFILE_LIST)))")

# All targets except all
TARGETS := iterm brew readline bash git tig hg vim ag ranger

# Phony targets
.PHONY: all $(TARGETS)

all: $(TARGETS)

iterm:
	open "$(ROOT)"/iterm/*.itermcolors

brew:
	brew bundle "$(ROOT)"

readline:
	$(CMD) "$(ROOT)"/.inputrc ~

bash:
	$(CMD) "$(ROOT)"/.bash_profile ~
	$(CMD) "$(ROOT)"/.bashrc ~

git:
	$(CMD) "$(ROOT)"/.gitconfig ~
	mkdir -pv ~/.config/git
	$(CMD) "$(ROOT)"/.config/git/ignore ~/.config/git/ignore

tig:
	$(CMD) "$(ROOT)"/.tigrc ~

hg:
	$(CMD) "$(ROOT)"/.hgrc ~

vim:
	$(CMD) "$(ROOT)"/.gvimrc "$(ROOT)"/.vimrc  ~
	cd "$(ROOT)"; find .vim -type d -exec mkdir -pv ~/{} \;
	cd "$(ROOT)"; find .vim -type f -exec $(CMD) "$(ROOT)"/{} ~/{} \;
	mkdir -pv ~/.vim/bundle
	cd ~/.vim/bundle; git clone https://github.com/gmarik/Vundle.vim.git
	vim +PluginInstall +PluginClean +qa

ag:
	$(CMD) "$(ROOT)"/.agignore ~

ranger:
	mkdir -pv ~/.config/ranger
	$(CMD) "$(ROOT)"/.config/ranger/rc.conf ~/.config/ranger/rc.conf
