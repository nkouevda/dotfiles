# Nikita Kouevda
# 2014/08/07

# Link if LN=1; copy otherwise
ifeq ($(LN),1)
  CMD := ln -fsv
else
  CMD := cp -fv
endif

# Location of this file
ROOT := $(shell dirname "$(realpath $(lastword $(MAKEFILE_LIST)))")

# Sublime Text 2 settings directory
ST2 := $(wildcard ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User)

# All targets except all
TARGETS := brew iterm readline bash git tig hg vim subl

# Phony targets
.PHONY: all $(TARGETS)

all: $(TARGETS)

brew:
	brew bundle "$(ROOT)"

iterm:
	open "$(ROOT)"/iterm/*.itermcolors

readline:
	$(CMD) "$(ROOT)"/.inputrc ~

bash:
	$(CMD) "$(ROOT)"/.bash_profile "$(ROOT)"/.bashrc ~

git:
	$(CMD) "$(ROOT)"/.gitconfig ~

tig:
	$(CMD) "$(ROOT)"/.tigrc ~

hg:
	$(CMD) "$(ROOT)"/.hgrc ~

vim:
	$(CMD) "$(ROOT)"/.gvimrc "$(ROOT)"/.vimrc  ~
	cd "$(ROOT)"; find .vim -type d -exec mkdir -pv ~/{} \;
	cd "$(ROOT)"; find .vim -type f -exec $(CMD) "$(ROOT)"/{} ~/{} \;

subl:
	cd "$(ROOT)"/subl; for file in *; do \
	  $(CMD) "$(ROOT)"/subl/"$$file" "$(ST2)"/"$$file"; done
