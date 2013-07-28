<!-- Nikita Kouevda -->
<!-- 2013/07/27 -->

# dotfiles

My dotfiles, for future reference and reuse.

## Setup

The following sequence of commands copies these dotfiles into your home
directory. Warning: this will overwrite existing files with the same names.
Also note that some information in `.gitconfig` and `.hgrc` is specific to me;
you probably want to edit those files before use.

    git clone https://github.com/nkouevda/dotfiles.git
    cp -r dotfiles/.{bash*,gitconfig,hgrc,inputrc,*vim*} ~
    rm -rf dotfiles

## Contents

### [`.bashrc`](.bashrc) and [`.bash_profile`](.bash_profile)

Configuration files for bash.

### [`.gitconfig`](.gitconfig) and [`.hgrc`](.hgrc)

Configuration files for git and mercurial.

### [`.inputrc`](.inputrc)

Configuration file for readline.

### [`.vimrc`](.vimrc] and [`.gvimrc`](.gvimrc)

Configuration files for Vim and gVim.

### [`.vim/colors/wombat.vim`](.vim/colors/wombat.vim)

A slightly improved version of the
[wombat256mod](http://www.vim.org/scripts/script.php?script_id=2465) color
scheme for Vim and gVim.
