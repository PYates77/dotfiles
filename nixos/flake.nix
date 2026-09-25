{
  description = "Paul's NixOS Config Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; # try to use same version as nixos
    };

    anifetch = {
      url = "github:Notenlish/anifetch";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 

    utils = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
    };
 

    impermanence.url = "github:nix-community/impermanence";

    nixos-hardware.url = "github:nixos/nixos-hardware";

  };

  # TODO: figure out what the good thing about explicit args is
  outputs = 
    { self
    , nixpkgs
    , home-manager
    , utils
    , impermanence
    , nixos-hardware
    , ... 
    }@inputs: {
      # thinknix is my thinkpad laptop
      nixosConfigurations.thinknix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-11th-gen
        ];
        specialArgs = {inherit inputs;};
      };
    };
}
