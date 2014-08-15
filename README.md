<!-- Nikita Kouevda -->
<!-- 2014/08/15 -->

# dotfiles

My dotfiles, for future reference and reuse.

## Installation

To install everything by copying:

    make

To create symbolic links instead, use `LN=1`:

    make LN=1

To install selectively, take a look at the [`Makefile`](Makefile). For example:

    make LN=1 readline bash git tig hg vim

Note that `.gitconfig` and `.hgrc` contain user-specific information.
