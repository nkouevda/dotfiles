# Return if not an interactive shell
[[ "$-" != *i* ]] && return

set -o pipefail

# Do not capture ^Q or ^S
stty start undef
stty stop undef

# e.g. curl does not default to ~/.config if this is unset
export XDG_CONFIG_HOME=~/.config

export INPUTRC=~/.config/readline/inputrc

# Enable `**` expansion
shopt -s globstar

# Do not attempt completion on an empty line
shopt -s no_empty_cmd_completion

# Review commands with history expansion before executing; retype if failed
shopt -s histverify histreedit
# Append to the history file instead of overwriting it
shopt -s histappend
# Ignore commands that start with whitespace; ignore and erase duplicates
export HISTCONTROL="ignoreboth:erasedups"
export HISTFILE=~/.local/state/bash/history
# Save more history
export HISTFILESIZE=1000
export HISTSIZE=1000

# Homebrew
if [[ "$(uname -s)" == "Darwin" ]]; then
  export HOMEBREW_AUTOREMOVE=1
  export HOMEBREW_NO_AUTO_UPDATE=1
  export HOMEBREW_NO_ENV_HINTS=1

  if [[ -x /opt/homebrew/bin/brew ]]; then
    brew_prefix="/opt/homebrew"
    export PATH="$brew_prefix/bin:$PATH"
  else
    brew_prefix="/usr/local"
  fi

  # Without g prefix
  export PATH="$brew_prefix/opt/coreutils/libexec/gnubin:$PATH"
  export PATH="$brew_prefix/opt/findutils/libexec/gnubin:$PATH"
  export PATH="$brew_prefix/opt/gawk/libexec/gnubin:$PATH"
  export PATH="$brew_prefix/opt/gnu-sed/libexec/gnubin:$PATH"
  export PATH="$brew_prefix/opt/grep/libexec/gnubin:$PATH"
  export MANPATH="$brew_prefix/opt/coreutils/libexec/gnuman:$MANPATH"
  export MANPATH="$brew_prefix/opt/findutils/libexec/gnuman:$MANPATH"
  export MANPATH="$brew_prefix/opt/gawk/libexec/gnuman:$MANPATH"
  export MANPATH="$brew_prefix/opt/gnu-sed/libexec/gnuman:$MANPATH"
  export MANPATH="$brew_prefix/opt/grep/libexec/gnuman:$MANPATH"

  export PATH="$brew_prefix/opt/openssl/bin:$PATH"
  export PATH="$brew_prefix/opt/python/libexec/bin:$PATH"
  export PATH="$brew_prefix/opt/ruby/bin:$PATH"
  export PATH="$(gem environment home)/bin:$PATH"

  bash_completion="$brew_prefix/etc/profile.d/bash_completion.sh"
  [[ -r "$bash_completion" ]] && source "$bash_completion"
  unset bash_completion

  unset brew_prefix
fi

# User bin
export PATH=~/"bin:$PATH"

# Faster cd
export CDPATH=.:~

# Generate and export LS_COLORS
if type dircolors &>/dev/null; then
  [[ -r ~/.config/dircolors ]] && source <(dircolors ~/.config/dircolors)
fi

# Inconsistent options between coreutils ls and mac os ls
if ls --version 2>/dev/null | grep --quiet coreutils; then
  alias ls="ls --escape --indicator-style=slash --color=auto"
  alias ll="ls -lh --time-style='+%F %T'"
else
  alias ls="ls -bpG"
  alias ll="ls -lh -D '%F %T'"
fi

alias la="ll -A"

# coreutils ls does not support -@ or -e, so this must be via mac os ls
if /bin/ls -@e &>/dev/null; then
  alias le="/bin/ls -bpG -lh -D '%F %T' -A -@e"
fi

# --gitignore and --metafirst were both added in tree 2.0.0
if tree --help 2>/dev/null | grep --quiet -- --gitignore; then
  alias lt="tree -a -F -C -I .git --gitignore --noreport"
  alias ltl="lt -pugDh --timefmt='%F %T' --metafirst -fi"
  alias lta="tree -a -F -C --noreport"
  alias ltal="lta -pugDh --timefmt='%F %T' --metafirst -fi"
else
  alias lt="tree -a -F -C -I .git --noreport"
  alias ltl="lt -pugDh --timefmt='%F %T' -fi"
  alias lta="tree -a -F -C --noreport"
  alias ltal="lta -pugDh --timefmt='%F %T' -fi"
fi

# Default grep options
alias grep="grep --ignore-case --color=auto"
# Default rg options
[[ -r ~/.config/ripgrep/config ]] && export RIPGREP_CONFIG_PATH=~/.config/ripgrep/config

# Default fzf options
export FZF_DEFAULT_OPTS="--no-256"
# `git ls-files` is much faster in large repos; fall back to `rg --files`
export FZF_DEFAULT_COMMAND="git ls-files 2>/dev/null || rg --files --follow --hidden --glob '!.git' 2>/dev/null"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Prune .git but not other dotdirs
export FZF_ALT_C_COMMAND="find -L . -mindepth 1 -name .git -prune -o -type d -print 2>/dev/null | cut -c 3-"
# Key bindings for fzf
[[ -r ~/.config/fzf/fzf.bash ]] && source ~/.config/fzf/fzf.bash
[[ -r ~/.config/fzf/fzf-git.sh ]] && source ~/.config/fzf/fzf-git.sh

# Case-insensitive search in less, unless the pattern contains uppercase chars
export LESS="--ignore-case"
# When the entire file fits on one screen, and -F/--quit-if-one-screen is not specified, show the
# file at the top of the screen, not at the bottom; this applies to less >= v618:
# https://github.com/gwsw/less/commit/98782c194f16ba93088d1033702172c3c00f0a61
# Adding -c/--clear-screen to LESS would have a similar effect, but that results in undesirable
# behavior when used in combination with -F/--quit-if-one-screen
export LESS_TERMCAP_NR=1
# Start blink, bold, reverse, standout, underline
export LESS_TERMCAP_mb="$(tput bold; tput setaf 1)"
export LESS_TERMCAP_md="$(tput bold; tput setaf 1)"
export LESS_TERMCAP_mr="$(tput bold; tput setaf 1)"
export LESS_TERMCAP_so="$(tput setaf 0; tput setab 3)"
export LESS_TERMCAP_us="$(tput bold; tput setaf 2)"
# End blink, bold, reverse ('me' ends all 3), standout, underline
export LESS_TERMCAP_me="$(tput sgr0)"
export LESS_TERMCAP_se="$(tput sgr0)"
export LESS_TERMCAP_ue="$(tput sgr0)"

# Use vim as the default editor
export EDITOR="vim"

# Alias tac if not already available
if ! type tac &>/dev/null; then
  alias tac="tail -r"
fi

# Synchronize the current history list with the history file
sync-bash-history() {
  # Append the history list to the history file
  history -a

  # Remove trailing whitespace; keep only the most recent copies of duplicates
  tac "$HISTFILE" \
    | awk '{ sub(/[ \t]+$/, "") } !uniq[$0]++' \
    | tac \
    | sponge "$HISTFILE"

  # Clear the history list and read the history file
  history -c
  history -r
}

# Reset prompt variables
reset-prompt() {
  local tput_reset="\[$(tput sgr0)\]"
  local tput_red="\[$(tput setaf 1)\]"
  local tput_green="\[$(tput setaf 2)\]"
  local tput_yellow="\[$(tput setaf 3)\]"
  local tput_blue="\[$(tput setaf 4)\]"
  local tput_magenta="\[$(tput setaf 5)\]"

  # Start timer before command execution; HACK: set ps_start via side effect of arithmetic evaluation
  export PS0='${PS0:ps_start=SECONDS, 0:0}'

  # Save `$?`, stop timer, and sync history after command execution
  export PROMPT_COMMAND='exit_status=$?; ps_end=$SECONDS; sync-bash-history;'

  PS1="$tput_reset"
  # Include `$USER@$HOSTNAME ` if connected via ssh
  [[ -n "$SSH_CONNECTION" ]] && PS1+="$tput_red\u@\h "
  # pwd
  PS1+="$tput_yellow\w"
  # Include duration of previous command in seconds if non-zero
  PS1+="$tput_blue"'$( (( ps_start >= 0 && ps_end > ps_start )) && echo " $(( ps_end - ps_start ))s" )'
  # Include exit status of previous command if non-zero
  PS1+="$tput_red"'$( (( ps_start >= 0 && exit_status )) && echo " $exit_status >" )'
  PS1+="$tput_green"'$( (( ps_start < 0 || ! exit_status )) && echo " >" )'
  # Set ps_start to -1 until next time PS0 is evaluated, to not show duration after empty commands
  PS1+="$tput_reset "'${PS0:ps_start=-1, 0:0}'
  export PS1

  # Max number of dirs to show in PS1's `\w`
  export PROMPT_DIRTRIM=3

  # Same as default `> `, but colored
  export PS2="$tput_green>$tput_reset "

  # For `set -x`, with colors like grep/rg
  export PS4="+ $tput_magenta\$0$tput_reset:$tput_green\$LINENO$tput_reset:"
}

reset-prompt

[[ -r /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion
[[ -r ~/.config/bash/completion.bash ]] && source ~/.config/bash/completion.bash
[[ -r ~/.config/bash/functions.bash ]] && source ~/.config/bash/functions.bash
[[ -r ~/.config/bash/local.bash ]] && source ~/.config/bash/local.bash

# Guarantee exit status 0
return 0
