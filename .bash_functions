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
  dd if=/dev/random iflag=count_bytes count="${1:-16}" 2>/dev/null
}

# Random hexadecimal; default 16 bytes
randhex() {
  randbin "$1" | xxd -p | tr -d '\n' && printf '\n'
}

# Random base 64; default 16 bytes
randb64() {
  randbin "$1" | base64 -w 0 && printf '\n'
}

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

# Command line pastebin
sprunge() {
  curl -F 'sprunge=<-' 'http://sprunge.us' 2>/dev/null
}

# Remove compiled python files under the given dirs; default current dir
rmpyc() {
  find -- "${@:-.}" -type f -name '*.py[co]' -delete
}

# Remove .DS_Store files under the given dirs; default current dir
rmds() {
  find -- "${@:-.}" -type f -name '.DS_Store' -delete
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
