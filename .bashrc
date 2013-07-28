# Nikita Kouevda
# 2013/07/27

# Return if not an interactive shell
[[ "$-" != *i* ]] && return

# Append to the history file instead of overwriting it
shopt -s histappend

# Ignore and erase duplicates, and ignore commands that start with whitespace
export HISTCONTROL="ignoreboth:erasedups"

# Use Vim as the default editor
export EDITOR="vim"

# Include GitHub commands, if available
if [[ -n "$(which hub)" ]]; then
    alias git="hub"
fi

# Color grep matches by default
export GREP_OPTIONS="--color=auto"

# System-dependent color options for ls
if [[ "$(uname -s)" == "Linux" ]]; then
    alias la="ls -Abhlp --color=auto"
else
    alias la="ls -Abhlp -G"
fi

# Color escape sequences
red_raw="\033[31m"
green_raw="\033[32m"
yellow_raw="\033[33m"
reset_raw="\033[m"

# Unless SunOS, surround color escape sequences in PS1 with \[ \]
if [[ "$(uname -s)" == "SunOS" ]]; then
    red="$red_raw"
    green="$green_raw"
    yellow="$yellow_raw"
    reset="$reset_raw"
else
    red="\[$red_raw\]"
    green="\[$green_raw\]"
    yellow="\[$yellow_raw\]"
    reset="\[$reset_raw\]"
fi

# Red user if root, green otherwise
[[ $UID -eq 0 ]] && user="$red" || user="$green"
user+="\u$reset"

# Red @ if display unavailable, green otherwise
[[ -z "${DISPLAY:+0}" ]] && at="$red" || at="$green"
at+="@$reset"

# Red host if connected via ssh, green otherwise
[[ -n "${SSH_CONNECTION:+0}" ]] && host="$red" || host="$green"
host+="\h$reset"

# Yellow working directory
dir="$yellow\W$reset"

# Red $ or # if non-zero exit status, normal otherwise
prompt='$([[ $? -ne 0 ]] && printf "%b" "$red_raw")\$'"$reset"

export PS1="$user$at$host $dir $prompt "

# If it exists and is readable, source ~/.bash_local; guarantee exit status 0
[[ -r ~/.bash_local ]] && . ~/.bash_local || command :
