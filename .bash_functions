# Uppercase
upper() {
  tr '[:lower:]' '[:upper:]'
}

# Lowercase
lower() {
  tr '[:upper:]' '[:lower:]'
}

# ROT13
rot13() {
  tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

# Lowercase UUID
uuid() {
  uuidgen | lower
}

# Random binary; default 16 bytes
randbin() {
  head -c "${1:-16}" /dev/random
}

# Random hexadecimal; default 16 bytes
randhex() {
  randbin "$1" | xxd -p | tr -d '\n' && printf '\n'
}

# Random base 64; default 16 bytes
randb64() {
  randbin "$1" | base64 -w 0 && printf '\n'
}

# Pretty `PATH`
path() {
  tr ':' '\n' <<<"$PATH"
}

# Create backup
bak() {
  if (( ! $# )); then
    printf "usage: %s <file>...\n" "$FUNCNAME" >&2
    return 1
  fi

  for file in "$@"; do
    cp -v -- "$file"{,.bak}
  done
}

# Restore backup
unbak() {
  if (( ! $# )); then
    printf "usage: %s <file>...\n" "$FUNCNAME" >&2
    return 1
  fi

  for file in "$@"; do
    mv -v -- "${file%.bak}"{.bak,}
  done
}

# Print current Unix time or convert given Unix times to dates
epoch() {
  if (( ! $# )); then
    date +"%s"
  else
    for t in "$@"; do
      date --date="@$t" +"%Y-%m-%d %H:%M:%S %z"
    done
  fi
}

# Search dictionary
dict() {
  if (( ! $# )); then
    printf "usage: %s <grep-args>\n" "$FUNCNAME" >&2
    return 1
  fi

  grep --ignore-case "$@" /usr/share/dict/words
}

# Command line pastebin
sprunge() {
  curl -F 'sprunge=<-' 'http://sprunge.us' 2>/dev/null
}

# Find files with unusual names (expected: chars between ` ` and `~`, inclusive)
find-bad-names() {
  find -- "${@:-.}" -regex '.*[^ -~].*'
}

# Find files with unusual permissions (expected: 755 for dirs and 644 for files)
find-bad-perms() {
  # TODO(nkouevda): Ignore files in git worktrees, not just in .git dirs
  find -- "${@:-.}" \
    -name .git -prune \
    -o -type d -not -perm 755 -ls \
    -o -type f -not -perm 644 -ls
}

# Remove compiled python files under the given dirs; default current dir
rmpyc() {
  find -- "${@:-.}" \( -type d -name __pycache__ -o -type f -name '*.py[co]' \) -delete
}

# Remove .DS_Store files under the given dirs; default current dir
rmds() {
  find -- "${@:-.}" -type f -name '.DS_Store' -delete
}

# Fuzzy kill
fkill() {
  ps aux \
    | fzf --exact --multi \
    | awk '{ print $2 }' \
    | xargs --no-run-if-empty --verbose kill
}

# Activate virtualenv, first prompting to create if necessary
venv() {
  if (( $# != 1 )); then
    printf "usage: %s <name>\n" "$FUNCNAME" >&2
    return 1
  fi

  local venv_name="$1"
  local venv_path=~/".virtualenvs/$venv_name"

  if [[ ! -d "$venv_path" ]]; then
    read -r -p "Create virtualenv \"$venv_name\"? [y/N]: "
    case "$REPLY" in
      [Yy]|[Yy][Ee][Ss])
        virtualenv "$venv_path"
        ;;
      *)
        return 1
        ;;
    esac
  fi

  source "$venv_path/bin/activate"
}

# Update brew
update-brew() {
  brew update && brew upgrade && brew cleanup --prune=0 -s
}

# Update vim plugins
update-plug() {
  vim +PlugUpgrade +PlugUpdate +PlugClean! +'helptags ~/.vim/plugged' +qa
}
