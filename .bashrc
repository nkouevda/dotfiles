# Nikita Kouevda
# 2014/10/02

# Return if not an interactive shell
[[ "$-" != *i* ]] && return

# If it exists and is readable, source ~/.bash_local
[[ -r ~/.bash_local ]] && . ~/.bash_local

# Do not capture ^Q and ^S
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

# Use Vim as the default editor
export EDITOR="vim"

# Color grep output
export GREP_OPTIONS="--color=auto"

# Color ls output
if ls --color=auto &>/dev/null; then
  alias ls="ls --color=auto"
else
  alias ls="ls -G"
fi

# Aliases for viewing directory contents
alias la="ls -Abhlp"
alias lt="tree -aC -I '.git|node_modules'"

# Alias tac if coreutils is not installed
if ! type tac &>/dev/null; then
  alias tac="tail -r"
fi

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

# Construct and export PS1
make_ps1() {
  local reset red green yellow user at host dir stat

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
  stat='$([[ $? -ne 0 ]] && printf "%b" "'"$red"'" || printf "%b" "'"$reset"'")'

  # user@host pwd $
  export PS1="\[$reset\]$user\u$at@$host\h $dir\W \[$stat\]\\$ \[$reset\]"
}

make_ps1
unset -f make_ps1
