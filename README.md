<!-- Nikita Kouevda -->
<!-- 2014/04/27 -->

# dotfiles

My dotfiles, for future reference and reuse.

## Installation

### Configuration and rc files

To copy all relevant files for Bash, git, Mercurial, tig, and Vim to `~`:

    cp -r .{bash_profile,gitconfig,{bash,hg,input,tig,{,g}vim}rc,vim} ~

Note that some information in `.gitconfig` and `.hgrc` is specific to me.

TODO: symlink.

### Homebrew

To run `Brewfile`:

    brew bundle

### iTerm2

To import all `.itermcolors` files in the `iterm/` directory:

    open iterm/*.itermcolors

### Sublime Text 2

To hard link all `.sublime-settings` files in the `subl/` directory to the
appropriate settings directory:

    find 'subl/' -type f -name '*.sublime-settings' -exec ln -fv {} \
        ~/'Library/Application Support/Sublime Text 2/Packages/User/' \;

## Contents

### [`.bashrc`](.bashrc), [`.bash_profile`](.bash_profile)

Configuration files for Bash.

### [`.gitconfig`](.gitconfig)

Configuration file for git.

### [`.hgrc`](.hgrc)

Configuration file for Mercurial.

### [`.inputrc`](.inputrc)

Configuration file for Readline.

### [`.tigrc`](.tigrc)

Configuration file for tig.

### [`.vimrc`](.vimrc), [`.gvimrc`](.gvimrc)

Configuration files for Vim and gVim.

### [`.vim/colors/nkouevda.vim`](.vim/colors/nkouevda.vim)

Color scheme for Vim and gVim, based on
[wombat256mod](http://www.vim.org/scripts/script.php?script_id=2465).

### [`Brewfile`](Brewfile)

Homebrew dependencies.

### [`iterm/nkouevda.itermcolors`](iterm/nkouevda.itermcolors)

Color scheme for iTerm2.

### [`subl/*`](subl/)

Settings for Sublime Text 2.
