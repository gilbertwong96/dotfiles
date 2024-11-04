#!/bin/sh

ln -sFfi $(PWD)/.tmux.conf ~/.tmux.conf
ln -sFfi $(PWD)/config.fish ~/.config/fish/config.fish
# Hardlink for kitty config
ln -Ffi $(PWD)/kitty.conf ~/.config/kitty/kitty.conf
ln -sFfi $(PWD)/starship.toml ~/.config/starship.toml
