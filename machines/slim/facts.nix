{
  formFactor = "portal";
  gui = true;
  headless = false;
  sshAuthorizedKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIkwZUBkhznVjOcbgGAfQUKYOQJtNjxnTT3LDM2KMgcMB"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM7RdfzUhnGivqsg+jlhyFb0V1yZY8YqZFmwpatZoDap"
  ];

  theme = {
    dark = true;
    cursor = {
      package = "bibata-cursors";
      name = "Bibata-Modern-Classic";
      size = 24;
    };
  };

  dotfiles.mode = "store-backed";

  network = {
    ethernet = false;
    wifi = true;
    useNetworkManager = true;
    useIwd = true;
    tinyIp = "192.168.8.108";
    mamaIp = "192.168.8.10";

    wireguard = {
      endpoint = "192.168.8.108:51821";
      address = "10.1.0.3/24";
    };

    tinyWg1PublicKey = "RyloTPHjCXGLn36WPczGPqnHJsjZrCjlog16AJyerGI=";
  };

  sync.folder = "/home/suazo/Sync";
}
