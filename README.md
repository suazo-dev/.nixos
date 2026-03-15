# Suazo custom modular NixOS framework

machines -> features -> components

## Build

cp /etc/nixos/hardware-configuration.nix ~/.nixos/machines/slim/hardware-configuration.nix
cd ~/.nixos
git add .
sudo nixos-rebuild build --flake .#slim

## Switch

sudo nixos-rebuild switch --flake .#slim

## Sessions

ly shows: niri, KDE Plasma, Hyprland
