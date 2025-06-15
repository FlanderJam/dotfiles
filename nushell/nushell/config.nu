# config.nu
#
# Installed by:
# version = "0.102.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.
$env.EDITOR = 'nvim'
$env.config.buffer_editor = "nvim"
$env.config.show_banner = false

alias nv = nvim
alias n. = nv ~/.config/nvim
alias zel = zellij -l welcome

use std/util "path add"
const FNM_PATH = "~/.local/share/fnm"
path add $FNM_PATH

const ZIG_NIGHTLY_PATH = "/opt/zig/nightly"
path add $ZIG_NIGHTLY_PATH

def nufzf [] {$in | each {|i| $i | to json --raw} | str join "\n" | fzf  | from json}

def zelTest [] {
    if 'ZELLIJ' in ($env | columns) {
        echo "Running in Zellij"
    } else {
        echo "Not running in Zellij"
    }
}

source ./fnm.nu
source ./deno.nu
source ./go.nu
# This was from rust, but it references $HOME, which nu doesn't seem to support
# source "~/.cargo/env.nu"
source ./rust.nu
source ./tauri.nu

# TODO: remove this when the nvidia driver issue is resolved
# https://discussion.fedoraproject.org/t/gdk-message-error-71-protocol-error-dispatching-to-wayland-display/127927/54
# https://github.com/tauri-apps/tauri/issues/10702
# https://github.com/OpenFusionProject/OpenFusionLauncher/issues/6
$env.WEBKIT_DISABLE_DMABUF_RENDERER = 1


# auto-completions
use auto-completions/git-completions.nu *
use auto-completions/rg-completions.nu *
use auto-completions/rustup-completions.nu *
use auto-completions/cargo-completions.nu *
use auto-completions/npm-completions.nu *
use auto-completions/docker-completions.nu *
