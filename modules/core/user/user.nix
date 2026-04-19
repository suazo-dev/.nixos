{ pkgs, spec, lib, ... }:
let
  hasRole = role: builtins.elem role spec.roles;
  alwaysOn = hasRole "gateway" || hasRole "core";
  n = spec.facts.network or { };
  wolInterface = n.lanInterface or null;
in {
  programs.zsh.enable = true;
  users.users.${spec.user}.shell = pkgs.zsh;

  environment.systemPackages = lib.mkIf alwaysOn [ pkgs.wakeonlan pkgs.ethtool ];

  systemd.targets = lib.mkIf alwaysOn {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  services.logind = lib.mkIf alwaysOn {
    lidSwitch = "ignore";
    lidSwitchExternalPower = "ignore";
    lidSwitchDocked = "ignore";
    settings.Login = {
      IdleAction = "ignore";
      HandleSuspendKey = "ignore";
      HandleHibernateKey = "ignore";
    };
  };

  systemd.services.enable-wake-on-lan = lib.mkIf (alwaysOn && (wolInterface != null)) {
    description = "Enable Wake-on-LAN";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-pre.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.ethtool}/bin/ethtool -s ${wolInterface} wol g";
    };
  };
}
