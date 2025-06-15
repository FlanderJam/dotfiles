# Cloning the Repo
Due to the use of submodule for neovim, you must clone the submodule as well.

```
git clone --recurse-submodules https://github.com/FlanderJam/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git submodule update --remote  # Gets latest from tracked branches
```

To update the neovim config and have it persist in this repo, you must do the following.

```
cd ~/.dotfiles
git submodule update --remote  # Pull latest from the tracked branch
git add nvim
git commit -m "Update nvim submodule to latest"
```
