{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { nixvim, flake-parts, ... }@inputs: {
      nixosModules.nixvim = nixvim.legacyPackages.x86_64-linux.makeNixvimWithModule {
        module = { ...}: { imports = [ ./config ]; };
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
}
