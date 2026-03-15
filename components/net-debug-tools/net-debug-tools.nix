{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tcpdump
    nmap
    nftables
    dnsutils
    net-tools
    iperf3
    traceroute
    wireshark-cli
  ];
}
