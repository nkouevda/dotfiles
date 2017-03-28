# dotfiles

My dotfiles.

## Installation

To install everything by copying:

    make

To create symbolic links instead, use `LN=1`:

    make LN=1

To install selectively, take a look at the [`Makefile`](Makefile). For example:

    make LN=1 ag bash ctags dircolors git hg python readline ssh tig vim

Note that `.gitconfig` and `.hgrc` contain user-specific information.
