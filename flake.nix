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
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = { nixpkgs, astal, home-manager, xtremeShell, ... } @inputs:
    let
      system = "x86_64-linux";
      overlay = final: prev: {
        xtremeShell = xtremeShell.packages.${system}.default;
        astalCli = astal.packages.${system}.default;
      };
      pkgs = import nixpkgs { 
        inherit system; 
        config.allowUnfree = true;
        overlays = [ overlay ]; 
      };
      spicetify = inputs.spicetify-nix.lib.mkSpicetify pkgs {};
    in {
      nixosConfigurations = {
        # Change host with --flake ./#HOSTNAME
        desktop = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [ 
            ./hosts/desktop
            ./nixos/configuration.nix 
          ];
        };
        
        laptop = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [
            ./hosts/laptop
            ./nixos/configuration.nix 
          ];
        };
      };

      homeConfigurations = {
        desktop = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = inputs // {host = "desktop"; inherit spicetify;};
          modules = [ ./homeManager/home.nix ];
        };
        laptop = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = inputs // {host = "laptop"; inherit spicetify;};
          modules = [ ./homeManager/home.nix ];
        };
      };
    };
}
