{
  lib,
  pkgs,
  spec,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs;
    lib.mkIf (!spec.facts.headless) [
      librewolf
      firefox
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  home-manager.users.${spec.user} = lib.mkIf (!spec.facts.headless) ({...}: {
    home.sessionVariables.BROWSER = "librewolf";
  });
}
