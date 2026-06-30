if  command -v fastfetch &> /dev/null; then
  fastfetch # Show system info
fi

function zvm_after_init() {
  bindkey '^Y' autosuggest-accept
}

chpwd() {
  if (( $+commands[eza] )); then
    eza --icons
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    ls -G
  else
    ls --color=auto
  fi
}

alias -g NE=' 2>/dev/null' # No error
alias -g WE=' 2>/tmp/shell-error.log' # Write error
alias -g NUL=' >/dev/null 2>&1' # No output

bindkey ' ' magic-space
