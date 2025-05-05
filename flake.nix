{
  description = "System config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xtremeShell = {
      url = "github:xtremethn/gtkshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    matugen = {
      url = "github:/InioX/Matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, astal, home-manager, xtremeShell, ... } @inputs:
    let
      system = "x86_64-linux";
      overlay = final: prev: {
        xtremeShell = xtremeShell.packages.${system}.default;
        astalCli = astal.packages.${system}.default;
      };
      pkgs = import nixpkgs { inherit system; overlays = [ overlay ]; };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        modules = [ ./nixos/configuration.nix ];
      };

      homeConfigurations.axel = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = inputs;
        modules = [ ./homeManager/home.nix ];
      };
    };
}
