#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias nv="nvim"
alias n.="nvim ~/config/nvim"

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
. "$HOME/.deno/env"
. "$HOME/.cargo/env"
export PATH=$PATH:/usr/local/go/bin

# This must go at bottom
eval "$(starship init bash)"

# opencode
export PATH=/home/flanderjam/.opencode/bin:$PATH
