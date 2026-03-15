{ lib, pkgs, spec, ... }:
{
  fonts = lib.mkIf (!spec.facts.headless) {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
    ];

    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "JetBrainsMono Nerd Font" ];
    };
  };
}
