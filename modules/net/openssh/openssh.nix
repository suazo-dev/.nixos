{ ... }:
{
  services.openssh.enable = true;

  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
    KbdInteractiveAuthentication = false;
    PubkeyAuthentication = true;
    X11Forwarding = false;
    TCPKeepAlive = true;
    ClientAliveInterval = 30;
    ClientAliveCountMax = 6;
  };
}
