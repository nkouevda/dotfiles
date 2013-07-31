# Nikita Kouevda
# 2013/07/30

# Return if not an interactive shell
[[ "$-" != *i* ]] && return

# Review commands with history expansion before executing
shopt -s histverify

# Append to the history file instead of overwriting it
shopt -s histappend

# Ignore commands that start with whitespace; ignore and erase duplicates
export HISTCONTROL="ignoreboth:erasedups"

# Use Vim as the default editor
export EDITOR="vim"

# Color grep matches by default
export GREP_OPTIONS="--color=auto"

# System-dependent aliases
if [[ "$(uname -s)" == "Linux" ]]; then
    alias la="ls -Abhlp --color=auto"
    alias reverse="tac"
else
    alias la="ls -Abhlp -G"
    alias reverse="tail -r"
fi

# Include GitHub commands, if available
if [[ -n "$(which hub)" ]]; then
    alias git="hub"
fi

# Temporary file for deduplicating the history file
tmp_histfile="/tmp/.bash_history.$$"

# Synchronize the current history list with the history file
function sync_history() {
    # Append the history list to the history file
    history -a

    # Remove duplicates from the history file, keeping the most recent copies
    if [[ -r "$HISTFILE" ]]; then
        reverse "$HISTFILE" | awk '!uniq[$0]++' | reverse > "$tmp_histfile"
        mv "$tmp_histfile" "$HISTFILE"
    fi

    # Clear the history list and read the history file
    history -c
    history -r
}

# Color escape sequences
reset_raw="\033[m"
reset="\[\033[m\]"
red_raw="\033[31m"
red="\[\033[31m\]"
green="\[\033[32m\]"
yellow="\[\033[33m\]"

# Red user if root, green otherwise
[[ $UID -eq 0 ]] && user="$red" || user="$green"

# Red @ if display unavailable, green otherwise
[[ -z "${DISPLAY:+0}" ]] && at="$red" || at="$green"

# Red host if connected via ssh, green otherwise
[[ -n "${SSH_CONNECTION:+0}" ]] && host="$red" || host="$green"

# Yellow working directory
dir="$yellow"

# Red $ or # if non-zero exit status, normal otherwise
symbol='$([[ $? -ne 0 ]] && printf "%b" "$red_raw" || printf "%b" "$reset_raw")'

# Synchronize history before every prompt
export PROMPT_COMMAND='sync_history;'
export PS1="$user\u$at@$host\h $dir\W \[$symbol\]\\$ $reset"

# If it exists and is readable, source ~/.bash_local; guarantee exit status 0
[[ -r ~/.bash_local ]] && . ~/.bash_local || :
