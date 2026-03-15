{
  description = "Suazo custom modular NixOS framework";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      flake =
        let
          lib = nixpkgs.lib;
          entries = builtins.readDir ./machines;
          machineNames =
            builtins.filter
              (n: entries.${n} == "directory" && builtins.pathExists (./machines + "/${n}/default.nix"))
              (builtins.attrNames entries);
          mkHost = import ./lib/mkHost.nix { inherit inputs lib; };
        in
        {
          nixosConfigurations = lib.genAttrs machineNames mkHost;
        };
    };
}
