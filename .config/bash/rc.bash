# Return if not an interactive shell
[[ "$-" != *i* ]] && return

set -o pipefail

# Do not capture ^Q or ^S
stty start undef
stty stop undef

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

export HOMEBREW_AUTOREMOVE=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1

# Homebrew paths
if [[ "$(uname -s)" == "Darwin" ]]; then
  # Without g prefix
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
  export PATH="/usr/local/opt/gawk/libexec/gnubin:$PATH"
  export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
  export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
  export MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
  export MANPATH="/usr/local/opt/gawk/libexec/gnuman:$MANPATH"
  export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
  export MANPATH="/usr/local/opt/grep/libexec/gnuman:$MANPATH"

  export PATH="/usr/local/opt/openssl/bin:$PATH"
  export PATH="/usr/local/opt/python/libexec/bin:$PATH"
  export PATH="/usr/local/opt/ruby/bin:$PATH"
  export PATH="$(gem environment home)/bin:$PATH"
fi

# User bin
export PATH=~/"bin:$PATH"

# Faster cd
export CDPATH=:~:~/Documents

# Generate and export `LS_COLORS`
[[ -r ~/.config/dircolors ]] && source <(dircolors ~/.config/dircolors)

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
alias lt="tree -a -F -C"
alias ltg="lt -I .git"

# Default grep options
alias grep="grep --ignore-case --color=auto"
# Default rg options
[[ -r ~/.config/ripgrep/config ]] && export RIPGREP_CONFIG_PATH=~/.config/ripgrep/config

# Default fzf options
export FZF_DEFAULT_OPTS="--no-256"
export FZF_CTRL_T_COMMAND="git ls-files 2>/dev/null || rg --files --hidden --glob '!.git' 2>/dev/null"
# Key bindings for fzf
[[ -r ~/.config/fzf/fzf.bash ]] && source ~/.config/fzf/fzf.bash

# Case-insensitive search in less, unless the pattern contains uppercase chars
export LESS="--ignore-case"
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
  local reset red green yellow prefix suffix

  # Color escape sequences
  reset="\[$(tput sgr0)\]"
  red="\[$(tput setaf 1)\]"
  green="\[$(tput setaf 2)\]"
  yellow="\[$(tput setaf 3)\]"

  # Red `user@host` if connected via ssh, empty otherwise
  [[ -n "$SSH_CONNECTION" ]] && prefix="$red\u@\h " || prefix=""

  # Red `$? >` if non-zero exit status, green `>` otherwise
  suffix='$(last=$?; (( last )) && printf "%b$last >" "'"$red"'" || printf "%b>" "'"$green"'")'

  # `$PWD >`
  export PS1="$reset$prefix$yellow\w $suffix$reset "

  # Include parent dirs in `PS1`
  export PROMPT_DIRTRIM=3

  # Synchronize history before every prompt
  export PROMPT_COMMAND="sync-bash-history;"

  # For `set -x`
  export PS4='+ $0:$LINENO: '
}

reset-prompt

[[ -r /usr/local/share/bash-completion/bash_completion ]] && source /usr/local/share/bash-completion/bash_completion
[[ -r ~/.config/bash/completion.bash ]] && source ~/.config/bash/completion.bash
[[ -r ~/.config/bash/functions.bash ]] && source ~/.config/bash/functions.bash
[[ -r ~/.config/bash/local.bash ]] && source ~/.config/bash/local.bash

# Guarantee exit status 0
return 0
