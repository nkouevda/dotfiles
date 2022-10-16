# Uppercase
upper() {
  tr '[:lower:]' '[:upper:]'
}

# Lowercase
lower() {
  tr '[:upper:]' '[:lower:]'
}

# Lowercase UUID
uuid() {
  uuidgen | lower
}

# Pretty `PATH`
path() {
  tr ':' '\n' <<<"$PATH"
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
    printf "usage: %s <grep-args>\n" "${FUNCNAME[0]}" >&2
    return 1
  fi

  grep --ignore-case "$@" /usr/share/dict/words
}

# Print all versions of the given program
versions() {
  if (( $# != 1 )); then
    printf "usage: %s <name>\n" "${FUNCNAME[0]}" >&2
    return 1
  fi

  local name="$1"
  local version

  while read -r path; do
    version="$("$path" --version 2>&1)"
    printf '%s: %s\n' "$path" "$version"
  done < <(which -a "$name")
}

# Pipe list of files as args to vim
xvim() {
  xargs --no-run-if-empty --open-tty vim "$@"
}

# Command line pastebin
sprunge() {
  curl -F 'sprunge=<-' 'http://sprunge.us' 2>/dev/null
}

# Find files with unusual names (expected: chars between ` ` and `~`, inclusive)
find-unusual-names() {
  find -- "${@:-.}" -regex '.*[^ -~].*'
}

# Find files with unusual permissions (expected: 755 for dirs and 644 for files)
find-unusual-perms() {
  # TODO(nkouevda): Ignore files in git worktrees, not just in .git dirs
  find -- "${@:-.}" \
    -name .git -prune \
    -o -type d -not -perm 755 -ls \
    -o -type f -not -perm 644 -ls
}

# Fix files with unusual permissions (expected: 755 for dirs and 644 for files)
fix-unusual-perms() {
  # TODO(nkouevda): Ignore files in git worktrees, not just in .git dirs
  find -- "${@:-.}" \
    -name .git -prune \
    -o -type d -not -perm 755 -print -exec chmod 755 {} +
  find -- "${@:-.}" \
    -name .git -prune \
    -o -type f -not -perm 644 -print -exec chmod 644 {} +
}

# Remove compiled python files under the given dirs; default current dir
rmpyc() {
  find -- "${@:-.}" \( -type d -name __pycache__ -o -type f -name '*.py[co]' \) -print -delete
}

# Remove .DS_Store files under the given dirs; default current dir
rmds() {
  find -- "${@:-.}" -type f -name '.DS_Store' -print -delete
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
    printf "usage: %s <name>\n" "${FUNCNAME[0]}" >&2
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
  brew update
  brew upgrade
  brew cleanup --prune=all
}

# Update vim plugins
update-plug() {
  vim +PlugUpgrade +PlugUpdate +PlugClean! +'helptags ~/.vim/plugged' +qa
}
