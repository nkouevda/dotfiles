# Nikita Kouevda
# 2014/12/25

# Return if not an interactive shell
[[ "$-" != *i* ]] && return

# GNU coreutils and gsed
if [[ "$(uname -s)" == "Darwin" ]]; then
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
  export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
fi

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

# Use vim as the default editor
export EDITOR="vim"

# Default fzf options
export FZF_DEFAULT_OPTS="--no-256"

# If it exists and is readable, set python startup file
[[ -r ~/.pystartup ]] && export PYTHONSTARTUP=~/.pystartup

# Alias tac if coreutils not installed
if ! type tac &>/dev/null; then
  alias tac="tail -r"
fi

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

# Colorized cat
ccat() {
  if (( ! $# )); then
    printf "usage: %s <files>...\n" "$FUNCNAME" >&2
    return 1
  fi

  for file in "$@"; do
    pygmentize -f terminal256 -O style=monokai -g -- "$file"
  done
}

# Create backup
bak() {
  if (( ! $# )); then
    printf "usage: %s <files>...\n" "$FUNCNAME" >&2
    return 1
  fi

  for file in "$@"; do
    cp -v -- "$file"{,.bak}
  done
}

# Restore backup
unbak() {
  if (( ! $# )); then
    printf "usage: %s <files>...\n" "$FUNCNAME" >&2
    return 1
  fi

  for file in "$@"; do
    mv -v -- "${file%.bak}"{.bak,}
  done
}

# Print current Unix time or convert given Unix times to dates
epoch() {
  if (( ! $# )); then
    date +%s
  else
    for t in "$@"; do
      date --date=@"$t"
    done
  fi
}

# Search dictionary
dict() {
  if (( ! $# )); then
    printf "usage: %s [<options>...] <pattern>\n" "$FUNCNAME" >&2
    return 1
  fi

  grep -i "$@" /usr/share/dict/words
}

# Lowercase uuid
uuid() {
  uuidgen | tr '[:upper:]' '[:lower:]'
}

# Remove .DS_Store files under the given dirs (default: current dir)
rmds() {
  find -- "${@:-.}" -type f -name '.DS_Store' -delete
}

# Remove compiled python files under the given dirs (default: current dir)
rmpyc() {
  find -- "${@:-.}" -type f -name '*.py[co]' -delete
}

# Update brew
rebrew() {
  brew update && brew upgrade && brew cleanup -s
}

# Update vim plugins
replug() {
  vim +PlugUpgrade +PlugUpdate +PlugClean! +'helptags ~/.vim/plugged' +qa
}

# View changes from last vim plugin update
dfplug() {
  vim +PlugDiff +only
}

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
  export PS1="\[$reset\]$user\u$at@$host\h $dir\W \[$status\]\\$ \[$reset\]"
}

make_ps1
unset -f make_ps1

# Source bash completion and local settings
[[ -r /usr/local/etc/bash_completion ]] && . /usr/local/etc/bash_completion
[[ -r ~/.bash_local ]] && . ~/.bash_local

# Guarantee exit status 0
return 0
