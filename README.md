<!-- Nikita Kouevda -->
<!-- 2014/08/07 -->

# dotfiles

My dotfiles, for future reference and reuse.

## Installation

To install everything by copying:

    make

To create symbolic links instead, use `LN=1`:

    LN=1 make

To install selectively, take a look at the [`Makefile`](Makefile). For example:

    LN=1 make readline bash git tig hg vim

Note that `.gitconfig` and `.hgrc` contain user-specific information.
