{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    jq
    unzip
    zip
    file
    p7zip
    pciutils
    usbutils
    iproute2
    gnugrep
    gawk
    gnumake
    bash
    wireguard-tools
  ];
}
