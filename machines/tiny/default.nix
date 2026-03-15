{
  hostName = "tiny";
  role = "gateway";
  user = "suazo";
  stateVersion = "25.11";
  homeStateVersion = "25.11";
  hardware = "hardware-configuration.nix";

  features = [
    "base/base"
    "network/gateway"
    "security/security"
    "observability/observability"
    "sync/sync"
  ];

  mutableUsers = true;
}
