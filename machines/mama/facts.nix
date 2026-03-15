{
  formFactor = "main-machine";
  gui = true;
  headless = false;

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
    ethernet = true;
    wifi = false;
    lanIp = "192.168.8.10";
    tinyIp = "192.168.8.40";
    teeIp = "192.168.8.20";
    slimIp = "192.168.8.30";
    mamaEgressInterface = "CHANGE_ME";
  };

  sync.folder = "/home/suazo/Sync";
}
