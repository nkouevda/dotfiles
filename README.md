# dotfiles

My dotfiles.

## Installation

To `cp` everything to `~`:

    make

To create symbolic links instead of copying, use `ln=1`:

    make ln=1

To install selectively, take a look at the [`Makefile`](Makefile). For example:

    make ln=1 bash ctags dircolors git hg python readline ripgrep ssh tig vim

Note that `.gitconfig` and `.hgrc` contain user-specific information.
