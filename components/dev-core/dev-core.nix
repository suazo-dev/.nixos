{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lazygit
    nil
    nixd
    lua-language-server
    nodePackages.bash-language-server
    shellcheck
    shfmt
    tree-sitter
    git
    direnv
    just
    mise
    uv
    gcc
    clang
    gdb
    cmake
    pkg-config
  ];

  programs.direnv.enable = true;
  programs.nix-ld.enable = true;
}
