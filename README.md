<!-- Nikita Kouevda -->
<!-- 2014/04/27 -->

# dotfiles

My dotfiles, for future reference and reuse.

## Usage

The following set of commands will copy these dotfiles into your home directory.
Warning: this will overwrite existing files with the same names. Also note that
some information in `.gitconfig` and `.hgrc` is specific to me; you probably
want to edit those files before use.

    git clone https://github.com/nkouevda/dotfiles.git
    rsync -av --exclude '.git' --exclude 'README.md' . ~
    rm -rf dotfiles

## Contents

### [`Brewfile`](Brewfile)

Homebrew dependencies.

### [`.bashrc`](.bashrc), [`.bash_profile`](.bash_profile)

Configuration files for Bash.

### [`.gitconfig`](.gitconfig), [`.gitignore`](.gitignore)

Configuration files for git.

### [`.hgrc`](.hgrc)

Configuration file for Mercurial.

### [`.inputrc`](.inputrc)

Configuration file for Readline.

### [`.tigrc`](.tigrc)

Configuration file for tig.

### [`.vimrc`](.vimrc), [`.gvimrc`](.gvimrc)

Configuration files for Vim and gVim.

### [`.vim/colors/wombat.vim`](.vim/colors/wombat.vim)

An improved version of the
[wombat256mod](http://www.vim.org/scripts/script.php?script_id=2465) color
scheme for Vim and gVim.
