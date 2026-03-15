{
  hostName = "slim";
  role = "portal";
  user = "suazo";
  stateVersion = "25.11";
  homeStateVersion = "25.11";
  hardware = "hardware-configuration.nix";

  features = [
    "base/base"
    "hardware/hardware"
    "terminal/terminal"
    "gui/gui"
    "dev/dev"
    "network/portal"
    "security/security"
    "observability/observability"
    "sync/sync"
  ];

  mutableUsers = true;
}
