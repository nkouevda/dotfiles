# Return if not an interactive shell
[[ "$-" != *i* ]] && return

set -o pipefail

# Homebrew paths
if [[ "$(uname -s)" == "Darwin" ]]; then
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

  export PATH="/usr/local/opt/openssl/bin:$PATH"
  export PATH="/usr/local/opt/python/libexec/bin:$PATH"
fi

# User bin
export PATH=~/bin:"$PATH"

# Do not capture ^Q or ^S
stty start undef
stty stop undef

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
export FZF_CTRL_T_COMMAND="rg --files --hidden --glob '!.git'"

# Key bindings for fzf
[[ -r ~/.fzf.bash ]] && source ~/.fzf.bash

# Python startup file
[[ -r ~/.pystartup ]] && export PYTHONSTARTUP=~/.pystartup

# Alias tac if coreutils not installed
if ! type tac &>/dev/null; then
  alias tac="tail -r"
fi

# Generate and export `LS_COLORS`
[[ -r ~/.dircolors ]] && eval "$(dircolors ~/.dircolors)"

# Color ls output
if ls --color=auto &>/dev/null; then
  alias ls="ls -bp --color=auto"
elif ls -G &>/dev/null; then
  alias ls="ls -bGp"
else
  alias ls="ls -bp"
fi

# Useful ls and tree variants
alias ll="ls -hl"
alias la="ll -A"
alias lt="tree -CF"
alias lta="lt -a"
alias ltg="lta -I .git"

# Default grep and rg options
alias grep="grep --color=auto"
alias rg="rg --hidden --glob '!.git' --smart-case --colors 'line:fg:cyan'"

# Synchronize the current history list with the history file
sync-history() {
  local tmp_histfile

  # Append the history list to the history file
  history -a

  if [[ -r "$HISTFILE" ]]; then
    tmp_histfile="$(mktemp "/tmp/.bash_history.$$.XXXXXX")"

    # Remove trailing whitespace; keep only the most recent copies of duplicates
    tac "$HISTFILE" \
      | awk '{ sub(/[ \t]+$/, "") } !uniq[$0]++' \
      | tac > "$tmp_histfile"
    mv "$tmp_histfile" "$HISTFILE"
  fi

  # Clear the history list and read the history file
  history -c
  history -r
}

# Reset prompt variables
reset-prompt() {
  local reset red green yellow user host dir status

  # Color escape sequences
  reset="$(tput sgr0)"
  red="$(tput setaf 1)"
  green="$(tput setaf 2)"
  yellow="$(tput setaf 3)"

  # Red user if root, green otherwise
  [[ $UID -eq 0 ]] && user="\[$red\]" || user="\[$green\]"

  # Red host if connected via ssh, green otherwise
  [[ -n "$SSH_CONNECTION" ]] && host="\[$red\]" || host="\[$green\]"

  # Yellow working directory
  dir="\[$yellow\]"

  # Red $ or # if non-zero exit status, normal otherwise
  status='$((( $? )) && printf "%b" "'"$red"'" || printf "%b" "'"$reset"'")'

  # user@host pwd $
  export PS1="\[$reset\]$user\u$host@\h $dir\w \[$status\]\\$ \[$reset\]"

  # Include parent directory in `PS1`
  export PROMPT_DIRTRIM=2

  # Synchronize history before every prompt
  export PROMPT_COMMAND="sync-history;"

  # Include basename of pwd in iTerm tab name
  if [[ -n "$ITERM_SESSION_ID" ]]; then
    export PROMPT_COMMAND+='printf "%b" "\033];$(basename "$PWD")\007";'
  fi

  # For `set -x`
  export PS4='+ $0:$LINENO: '
}

reset-prompt

# Source bash completion, functions, and local settings
[[ -r /usr/local/share/bash-completion/bash_completion ]] && source /usr/local/share/bash-completion/bash_completion
[[ -r ~/.bash_completion ]] && source ~/.bash_completion
[[ -r ~/.bash_functions ]] && source ~/.bash_functions
[[ -r ~/.bash_local ]] && source ~/.bash_local

# Guarantee exit status 0
return 0
