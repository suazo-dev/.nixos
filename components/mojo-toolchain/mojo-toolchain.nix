{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pixi
    patchelf
    pkg-config
  ];
}
