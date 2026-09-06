# My Config Files

## nvim
```
cp ~/.config/nvim ~/.config/nvim.backup -r
ls -ld ~/.config/nvim.backup

rm -rf ~/.config/nvim
ln -s ~/dotfiles/nvim ~/.config/nvim
ls -ld ~/.config/nvim
```

## starship
```
cp ~/.config/starship.toml ~/.config/starship.toml.backup
rm ~/.config/starship.toml
ln -s ./starship/starship.toml ~/.config/starship.toml
ls -l ~/.config/starship.toml
```

## tmux
```
cp ~/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf.backup
rm ~/.config/tmux/tmux.conf
mkdir -p ~/.config/tmux
ln -s ~/dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf
ls -l ~/.config/tmux/tmux.conf
```

## wezterm
```
# WSL
cp ./wezterm/wezterm.lua /mnt/c/Users/<username>/.config/wezterm/wezterm.lua
```

## ZSH
```
cp ~/.zshrc ~/.zshrc.backup
rm ~/.zshrc
ln -s ./zsh/.zshrc ~/.zshrc
ls -l ~/.zshrc
```
