{ pkgs, spec, ... }:
{
  home-manager.users.${spec.user} = { ... }: {
    programs.git = {
      enable = true;
      package = pkgs.git;
      userName = "suazo-dev";
      userEmail = "me@suazo.dev";
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = false;
      };
    };
  };
}
