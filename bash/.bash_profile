#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.deno/env"
. "$HOME/.cargo/env"

export PATH="$PATH:$HOME/.local/share/fnm"


# Added by Toolbox App
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

