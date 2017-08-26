_venv_complete() {
  local command current previous paths filenames

  command="$1"
  current="$2"
  previous="$3"

  paths=(~/".virtualenvs/"*)
  filenames=("${paths[@]##*/}")

  if [[ -e "${paths[0]}" ]]; then
    COMPREPLY=($(compgen -W '${filenames[@]}' -- "$current"))
  fi
}

complete -F _venv_complete venv
