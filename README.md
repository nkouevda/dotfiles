<!-- Nikita Kouevda -->
<!-- 2014/04/27 -->

# dotfiles

My dotfiles, for future reference and reuse.

## Usage

The following sequence of commands will copy these dotfiles into your home
directory. Warning: this will overwrite existing files with the same names. Also
note that some information in `.gitconfig` and `.hgrc` is specific to me; you
probably want to edit those files before use.

    git clone https://github.com/nkouevda/dotfiles.git
    cp -r dotfiles/.{bash_profile,gitconfig,{bash,hg,input,tig,{,g}vim}rc,vim} ~
    rm -rf dotfiles

## Contents

### [`Brewfile`](Brewfile)

Homebrew dependencies.

### [`.bash_profile`](.bash_profile), [`.bashrc`](.bashrc),
[`.inputrc`](.inputrc)

Configuration files for bash and readline.

### [`.gitconfig`](.gitconfig), [`.tigrc`](.tigrc), [`.hgrc`](.hgrc)

Configuration files for git, tig, and mercurial.

### [`.vimrc`](.vimrc), [`.gvimrc`](.gvimrc)

Configuration files for Vim and gVim.

### [`.vim/colors/wombat.vim`](.vim/colors/wombat.vim)

An improved version of the
[wombat256mod](http://www.vim.org/scripts/script.php?script_id=2465) color
scheme for Vim and gVim.
