<!-- Nikita Kouevda -->
<!-- 2014/08/06 -->

# dotfiles

My dotfiles, for future reference and reuse.

## Installation

### Configuration and rc files

To copy all files for Bash, git, Mercurial, tig, and Vim to `~`:

    cp -r .{bash_profile,{bash,{g,}vim,hg,input,tig}rc,gitconfig,vim} ~

To instead create symbolic links in `~`:

    for file in .{bash_profile,{bash,{g,}vim,hg,input,tig}rc,gitconfig}; do
      ln -fsv "$PWD/$file" ~
    done
    mkdir -p ~/.vim/colors/ ~/.vim/UltiSnips/
    for file in .vim/colors/*.vim; do
      ln -fsv "$PWD/$file" ~/.vim/colors/
    done
    for file in .vim/UltiSnips/*.snippets; do
      ln -fsv "$PWD/$file" ~/.vim/UltiSnips/
    done

Note that `.gitconfig` and `.hgrc` contain user information specific to me.

### Homebrew

To run `Brewfile`:

    brew bundle

### iTerm2

To import all `.itermcolors` files in the `iterm/` directory:

    open iterm/*.itermcolors

### Sublime Text 2

To hard link all `.sublime-settings` files in the `subl/` directory to the
appropriate settings directory:

    find subl/ -type f -name '*.sublime-settings' -exec ln -fv {} \
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

### [`.vim/colors/monokai.vim`](.vim/colors/monokai.vim)

Color scheme for Vim and gVim, based on
[Monokai.tmTheme](https://github.com/textmate/monokai.tmbundle).

### [`.vim/UltiSnips/*`](.vim/UltiSnips/)

UltiSnips snippets for Vim.

### [`Brewfile`](Brewfile)

Homebrew dependencies.

### [`iterm/monokai.itermcolors`](iterm/monokai.itermcolors)

Color scheme for iTerm2, based on the `gui` colors in
[monokai.vim](.vim/colors/monokai.vim).

### [`subl/*`](subl/)

Settings for Sublime Text 2.
