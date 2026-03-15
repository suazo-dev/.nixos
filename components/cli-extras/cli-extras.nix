{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tree
    lsof
    psmisc
    inetutils
    rsync
    pv
  ];
}
