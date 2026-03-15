{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gleam
    erlang
    rebar3
  ];
}
