{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bear
    clang
    clang-tools
    cmake
    gcc
    gdb
  ];
}
