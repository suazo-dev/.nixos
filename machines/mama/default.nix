{
  hostName = "mama";
  roles = [
    "core"
    "workstation"
    "storage"
  ];
  user = "suazo";
  stateVersion = "25.11";
  homeStateVersion = "25.11";
  hardware = "hardware-configuration.nix";

  features = [
    "core/core"
    "terminal/terminal"
    "gui/gui"
    "dev/dev"
    "cyber/cyber"
    "net/net"
  ];

  extraModules = [ ];

  mutableUsers = true;
}
