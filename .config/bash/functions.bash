### Strings

if [[ "$(uname -s)" == "Linux" ]]; then
  pbcopy() {
    xclip -selection clipboard -in
  }
  export -f pbcopy

  pbpaste() {
    xclip -selection clipboard -out
  }
  export -f pbpaste
fi

upper() {
  tr '[:lower:]' '[:upper:]'
}

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
  paste -s -d ':'
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
    local t
    for t in "$@"; do
      date-rfc-3339 --date="@$t"
    done
  fi
}

### Helper functions

# Count args and print each separately, to debug bash quoting issues
debug-args() {
  printf "count: %s\n" "$#"
  local i
  for (( i = 1; i <= $#; ++i )); do
    printf "%s: %q\n" "$i" "${!i}"
  done
}
export -f debug-args

# Prompt yes/no and return 0 if response was "y" or "yes", ignoring case
prompt-yes-no() {
  local prompt='[y/N]: '
  if (( $# )); then
    prompt="$* $prompt"
  fi

  read -r -p "$prompt"
  [[ "$REPLY" =~ ^[Yy]([Ee][Ss])?$ ]]
}
export -f prompt-yes-no

# ruff
rr() {
  ruff check --fix "$@" && ruff format "$@"
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

replace-all() {
  if (( $# != 2 )); then
    printf "usage: %s <pattern> <replacement>\n" "${FUNCNAME[0]}" >&2
    return 1
  fi

  local pattern="$1"
  local replacement="$2"

  # GNU sed allows `-i` or `-i''` but not `-i ''`; BSD sed allows `-i ''` but not `-i` or `-i''`
  if sed --version &>/dev/null; then
    local in_place=('-i')
  else
    local in_place=('-i' '')
  fi

  # Try different delimiters, in case pattern or replacement contain these chars
  local d
  for d in '/' '@' '#' ';' ':'; do
    if [[ "$pattern" != *"$d"* && "$replacement" != *"$d"* ]]; then
      # xargs without `--no-run-if-empty` so that we get `sed: no input files`
      rg -l -- "$pattern" | xargs sed "${in_place[@]}" -E "s$d$pattern$d$replacement${d}g"
      return "$?"
    fi
  done

  printf "error: Failed to find a suitable delimiter\n" >&2
  return 1
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

# Edit search results via quickfix list
vrg() {
  if (( ! $# )); then
    printf "usage: %s <rg-args>\n" "${FUNCNAME[0]}" >&2
    return 1
  fi

  vim -q <(rg --vimgrep "$@")
}

# Use stdin as args to vim
xvim() {
  xargs --no-run-if-empty --open-tty vim "$@"
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
    prompt-yes-no "Skip non-file(s) and edit file(s)?" || return 1
  fi

  type -a -p "$name" \
    | fzf --select-1 --multi \
    | xvim
}

### Files and dirs

# cd git root
cdg() {
  local dir="$(git rev-parse --show-toplevel)"
  [[ -n "$dir" ]] && cd "$dir"
}

# Similar to `git diff --no-index`
diff() {
  if [[ -t 1 ]]; then
    command diff --unified --color=always "$@" \
      | less --quit-if-one-screen --Raw-control-chars --no-init
  else
    command diff --unified "$@"
  fi
}

pdiff() {
  command pdiff "$@" \
    | less --quit-if-one-screen --Raw-control-chars --no-init
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

find-recently-modified() {
  find -- "${@:-.}" -type f -printf '%T+ %p\n' \
    | sort -nr
}

# Find files with unusual names (expected: chars between ` ` and `~`, inclusive)
find-unusual-names() {
  find -- "${@:-.}" -regex '.*[^ -~].*'
}

# Find unusual permissions (expected: 755 for dirs and 644 for files), excluding git repos
find-unusual-perms() {
  find -- "${@:-.}" \
    -type d -not -perm 755 -ls \
    -o -type f -not -perm 644 -ls \
    , \
    -type d -exec [ -d {}/.git ] \; -prune
}

# Fix unusual permissions (expected: 755 for dirs and 644 for files), excluding git repos
fix-unusual-perms() {
  find -- "${@:-.}" \
    -type d -not -perm 755 -print -exec chmod 755 {} \; \
    -o -type f -not -perm 644 -print -exec chmod 644 {} + \
    , \
    -type d -exec [ -d {}/.git ] \; -prune
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

# `ps u` minus some columns; also default to `-A`, a.k.a. `-e` or `-ax` or `ax`
# Inconsistent options between procps and mac os ps
if ps --version 2>/dev/null | grep --quiet procps; then
  psu() {
    command ps -o 'user,pid,%cpu,%mem,cputime,command' --sort '-%cpu' "${@:--A}"
  }
else
  psu() {
    command ps -o 'user,pid,%cpu,%mem,cputime,command' -r "${@:--A}"
  }
fi
export -f psu

# Default to `psu` if no args
ps() {
  if (( ! $# )); then
    psu
  else
    command ps "$@"
  fi
}

fps() {
  psu | fzf \
    --header-lines 1 \
    --reverse \
    --bind 'ctrl-r:reload(psu)' \
    --multi
}

# Fuzzy kill
fkill() {
  local pids
  mapfile -t pids < <(fps | awk '{ print $2 }')
  (( ! "${#pids[@]}" )) && return 1

  psu -ww -p "${pids[@]}"
  echo
  prompt-yes-no kill "${pids[@]}" && kill "${pids[@]}"
}

reset-dns() {
  dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
}

### Dependencies

# Activate venv, first prompting to create if necessary
venv() {
  if (( $# )); then
    printf "usage: %s\n" "${FUNCNAME[0]}" >&2
    return 1
  fi

  local venv_path=.venv

  if [[ ! -d "$venv_path" ]]; then
    prompt-yes-no "Create venv \"$venv_path\"?" || return 1
  fi

  python -m venv --prompt venv "$venv_path"
  source "$venv_path/bin/activate"
}

brew-upgrade() {
  brew update
  brew upgrade
  brew cleanup --prune=all
}

plug-update() {
  vim -c PlugUpgrade -c PlugUpdate -c 'PlugClean!' -c qa
}

upgrade-deps() {
  brew-upgrade
  plug-update
}
