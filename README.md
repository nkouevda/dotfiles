# dotfiles

My dotfiles.

See also [nkouevda/bin](https://github.com/nkouevda/bin).

## Installation

To `cp` everything to `~`:

    make

To create symbolic links instead of copying, use `ln=1`:

    make ln=1

To install selectively, see `targets` in [`Makefile`](Makefile). For example:

    make ln=1 bash bat ctags curl dig dircolors fzf gh git karabiner kitty less readline ripgrep ssh tig vim
