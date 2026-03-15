{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ripgrep
    fd
    fzf
    zoxide
    atuin
    eza
    bat
    delta
    btop
    tealdeer
  ];
}
