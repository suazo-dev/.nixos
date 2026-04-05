{
  inputs,
  lib,
}: machineName: let
  root = ../.;
  defaults = import ./defaults.nix;
  schema = import ./schema.nix {inherit lib;};

  machinePath = root + "/machines/${machineName}/default.nix";
  factsPath = root + "/machines/${machineName}/facts.nix";

  rawMachine = import machinePath;
  checkedMachine = schema.validateMachine machineName rawMachine;

  rawFacts =
    if builtins.pathExists factsPath
    then import factsPath
    else {};
  facts = schema.validateFacts machineName rawFacts;

  spec =
    defaults
    // checkedMachine
    // {
      features =
        lib.unique ((defaults.features or []) ++ (checkedMachine.features or []));
      extraComponents = checkedMachine.extraComponents or [];
      extraGroups =
        lib.unique ((defaults.extraGroups or []) ++ (checkedMachine.extraGroups or []));
      allowedUnfree =
        lib.unique ((defaults.allowedUnfree or []) ++ (checkedMachine.allowedUnfree or []));
      mutableUsers = checkedMachine.mutableUsers or defaults.mutableUsers;
      facts = facts;
    };

  featureResolver = import ./resolve/features.nix {
    inherit lib schema machineName;
    root = root;
  };

  componentResolver = import ./resolve/components.nix {
    root = root;
    inherit machineName;
  };

  resolvedFeatures = featureResolver.resolve spec.features;

  componentNames = lib.unique (
    lib.concatLists (map (f: f.components or []) resolvedFeatures.features)
    ++ spec.extraComponents
  );

  componentPaths = componentResolver.paths componentNames;
  hardwarePath = root + "/machines/${machineName}/${spec.hardware}";

  userModule = {
    users.mutableUsers = spec.mutableUsers;

    users.users.${spec.user} = {
      isNormalUser = true;
      extraGroups = spec.extraGroups;
      openssh.authorizedKeys.keys = spec.facts.sshAuthorizedKeys or [];
    };
  };

  hostCoreModule = {
    networking.hostName = spec.hostName;
    system.stateVersion = spec.stateVersion;

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "backup";
    home-manager.extraSpecialArgs = {
      inherit spec machineName inputs;
    };

    home-manager.users.${spec.user} = {...}: {
      home.username = spec.user;
      home.homeDirectory = "/home/${spec.user}";
      home.stateVersion = spec.homeStateVersion;
    };
  };

  unfreeModule = import ./resolve/unfree.nix {inherit lib spec;};
in
  inputs.nixpkgs.lib.nixosSystem {
    system = spec.system;
    specialArgs = {
      inherit inputs spec machineName;
    };
    modules =
      [
        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModules.home-manager
        userModule
        hostCoreModule
        unfreeModule
      ]
      ++ lib.optional (builtins.pathExists hardwarePath) hardwarePath
      ++ componentPaths;
  }
