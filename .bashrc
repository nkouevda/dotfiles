# Return if not an interactive shell
[[ "$-" != *i* ]] && return

# GNU coreutils and gsed
if [[ "$(uname -s)" == "Darwin" ]]; then
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
  export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
fi

# User bin
export PATH=~/bin:"$PATH"

# Do not capture ^Q or ^S
stty start undef
stty stop undef

# Review commands with history expansion before executing; retype if failed
shopt -s histverify histreedit

# Append to the history file instead of overwriting it
shopt -s histappend

# Ignore commands that start with whitespace; ignore and erase duplicates
export HISTCONTROL="ignoreboth:erasedups"

# Save more history
export HISTSIZE=1000

# Do not save history for less
export LESSHISTFILE="/dev/null"

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

# Default fzf options
export FZF_DEFAULT_OPTS="--no-256"

# Key bindings for fzf
[[ -r ~/.fzf.bash ]] && . ~/.fzf.bash

# Python startup file
[[ -r ~/.pystartup ]] && export PYTHONSTARTUP=~/.pystartup

# Alias tac if coreutils not installed
if ! type tac &>/dev/null; then
  alias tac="tail -r"
fi

# Generate and export LS_COLORS
[[ -r ~/.dircolors ]] && eval "$(dircolors ~/.dircolors)"

# Color ls output
if ls --color=auto &>/dev/null; then
  alias ls="ls --color=auto"
else
  alias ls="ls -G"
fi

# Aliases for viewing directory contents
alias la="ls -Abhlp"
alias lr="la -R"
alias lt="tree -aC -I '.git|node_modules'"

# Color grep output
alias grep="grep --color=auto"

# Synchronize the current history list with the history file
sync_history() {
  local tmp_hist

  # Append the history list to the history file
  history -a

  if [[ -r "$HISTFILE" ]]; then
    # Temporary file for deduplicating the history file
    tmp_hist=$(mktemp "/tmp/.bash_history.$$.XXXXXX")

    # Keep only the most recent copies of duplicates; remove trailing whitespace
    tac "$HISTFILE" | awk '{sub(/[ \t]+$/, "")} !uniq[$0]++' | tac > "$tmp_hist"
    mv "$tmp_hist" "$HISTFILE"
  fi

  # Clear the history list and read the history file
  history -c
  history -r
}

# Synchronize history before every prompt
export PROMPT_COMMAND="sync_history;"

# Include parent directory in PS1
export PROMPT_DIRTRIM=2

# Construct and export PS1
make_ps1() {
  local reset red green yellow user at host dir status

  # Color escape sequences
  reset="$(tput sgr0)"
  red="$(tput setaf 1)"
  green="$(tput setaf 2)"
  yellow="$(tput setaf 3)"

  # Red user if root, green otherwise
  [[ $UID -eq 0 ]] && user="\[$red\]" || user="\[$green\]"

  # Red @ if display unavailable, green otherwise
  [[ -z "${DISPLAY+set}" ]] && at="\[$red\]" || at="\[$green\]"

  # Red host if connected via ssh, green otherwise
  [[ -n "${SSH_CONNECTION+set}" ]] && host="\[$red\]" || host="\[$green\]"

  # Yellow working directory
  dir="\[$yellow\]"

  # Red $ or # if non-zero exit status, normal otherwise
  status='$((( $? )) && printf "%b" "'"$red"'" || printf "%b" "'"$reset"'")'

  # user@host pwd $
  export PS1="\[$reset\]$user\u$at@$host\h $dir\w \[$status\]\\$ \[$reset\]"
}

make_ps1
unset -f make_ps1

# Source bash completion, bash functions, and local settings
[[ -r /usr/local/etc/bash_completion ]] && . /usr/local/etc/bash_completion
[[ -r ~/.bash_functions ]] && . ~/.bash_functions
[[ -r ~/.bash_local ]] && . ~/.bash_local

# Guarantee exit status 0
return 0
