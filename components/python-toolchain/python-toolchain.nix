{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.virtualenv
    pyright
    ruff
    black
    python3Packages.debugpy
    python3Packages.ipython
  ];
}
