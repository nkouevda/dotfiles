<!-- Nikita Kouevda -->
<!-- 2014/10/12 -->

# dotfiles

My dotfiles.

## Installation

To install everything by copying:

    make

To create symbolic links instead, use `LN=1`:

    make LN=1

To install selectively, take a look at the [`Makefile`](Makefile). For example:

    make LN=1 readline bash git tig hg vim ag ranger

Note that `.gitconfig` and `.hgrc` contain user-specific information.
