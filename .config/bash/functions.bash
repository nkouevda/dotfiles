### Strings

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

# Change `:`-separated into `\n`-separated, e.g. `split: "$MANPATH"`
split:() {
  # If stdin is a terminal, take `$1` as input, or default to `$PATH`
  if [[ -t 0 ]]; then
    tr ':' '\n' <<<"${1:-$PATH}"
  else
    tr ':' '\n'
  fi
}

# Change `\n`-separated into `:`-separated, e.g. to reconstruct `$PATH`
join:() {
  tr '\n' ':'
}

### Dates

date-rfc-3339() {
  command date --rfc-3339=seconds "$@"
}

# Default to `--rfc-3339=seconds` if no args
date() {
  if (( ! $# )); then
    date-rfc-3339
  else
    command date "$@"
  fi
}

# Print seconds since epoch, or pretty print given seconds since epoch
epoch() {
  if (( ! $# )); then
    command date '+%s'
  else
    for t in "$@"; do
      date-rfc-3339 --date="@$t"
    done
  fi
}

### Helper functions

# Prompt yes/no and return 0 if response was "y" or "yes", ignoring case
yes-no() {
  local prompt="[y/N]: "
  if (( $# )); then
    prompt="$@ $prompt"
  fi

  read -r -p "$prompt"
  [[ "$REPLY" =~ ^[Yy]([Ee][Ss])?$ ]]
}

### Search

# Highlight
hl() {
  rg --passthru "$@"
}

# Sorted
rgs() {
  rg --sort path "$@"
}

# Search dictionary
dict() {
  if (( ! $# )); then
    printf "usage: %s <rg-args>\n" "${FUNCNAME[0]}" >&2
    return 1
  fi

  rg --ignore-case "$@" /usr/share/dict/words
}

### Edit

# Use stdin as args to vim
xvim() {
  xargs --no-run-if-empty --open-tty vim "$@"
}

# Edit search results via quickfix list
vrg() {
  if (( ! $# )); then
    printf "usage: %s <rg-args>\n" "${FUNCNAME[0]}" >&2
    return 1
  fi

  vim -q <(rg --vimgrep "$@")
}

# Edit the given program if it's a file
vtype() {
  if (( $# != 1 )); then
    printf "usage: %s <name>\n" "${FUNCNAME[0]}" >&2
    return 1
  fi

  local name="$1"

  type "$name" >/dev/null || return 1

  if [[ "$(type -t "$name")" != "file" ]]; then
    printf 'error: not a file\n\n' >&2
    type -a "$name" >&2
    printf '\n' >&2
    yes-no "Skip non-files and edit file(s)?" || return 1
  fi

  type -a -p "$name" \
    | fzf --select-1 --multi \
    | xvim
}

### Files

# Similar to `git diff --no-index`
diff() {
  if [[ -t 1 ]]; then
    command diff --unified --color=always "$@" \
      | less --quit-if-one-screen --Raw-control-chars --no-init
  else
    command diff --unified "$@"
  fi
}

# Print all versions of the given program
versions() {
  if (( $# != 1 )); then
    printf "usage: %s <name>\n" "${FUNCNAME[0]}" >&2
    return 1
  fi

  local name="$1"
  local version

  type "$name" >/dev/null || return 1

  while read -r path; do
    version="$("$path" --version 2>&1)"
    printf '%s: %s\n' "$path" "$version"
  done < <(type -a -p "$name")
}

# Command line pastebin
sprunge() {
  curl -F 'sprunge=<-' 'http://sprunge.us' 2>/dev/null
}

find-recently-modified() {
  find -- "${@:-.}" -type f -printf '%T+ %p\n' \
    | sort --numeric-sort --reverse
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

find-xattr() {
  xattr -l -v -r "${@:-.}"
}

rm-xattr() {
  xattr -c -r "${@:-.}"
}

# Remove compiled python files under the given dirs; default current dir
rm-pyc() {
  find -- "${@:-.}" \( -type d -name __pycache__ -o -type f -name '*.py[co]' \) -print -delete
}

# Remove .DS_Store files under the given dirs; default current dir
rm-ds() {
  find -- "${@:-.}" -type f -name '.DS_Store' -print -delete
}

### Processes

psg() {
  ps aux | rg "$@"
}

# Fuzzy kill
fkill() {
  ps aux \
    | fzf --exact --multi \
    | awk '{ print $2 }' \
    | xargs --no-run-if-empty --verbose kill
}

reset-dns() {
  dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
}

### Dependencies

# Activate virtualenv, first prompting to create if necessary
venv() {
  if (( $# != 1 )); then
    printf "usage: %s <name>\n" "${FUNCNAME[0]}" >&2
    return 1
  fi

  local venv_name="$1"
  local venv_path=~/".virtualenvs/$venv_name"

  if [[ ! -d "$venv_path" ]]; then
    yes-no "Create virtualenv \"$venv_name\"?" || return 1
  fi

  virtualenv "$venv_path"
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

update-deps() {
  update-brew
  update-plug
}
