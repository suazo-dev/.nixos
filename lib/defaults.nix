{
  system = "x86_64-linux";
  user = "suazo";

  extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
  features = [ "base/base" "security/security" ];
  allowedUnfree = [ ];
  mutableUsers = true;
}
