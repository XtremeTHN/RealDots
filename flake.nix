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
    gprompt.url = "github:xtremethn/gprompt";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    zen = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvchad-starter = {
      url = "github:XtremeTHN/nvchad-starter";
      flake = false;
    };
    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nvchad-starter.follows = "nvchad-starter";
    };
  };

  outputs = { nixpkgs, astal, home-manager, xtremeShell, nix4nvchad, gprompt, zen, ... } @inputs:
    let
      system = "x86_64-linux";
      overlay = final: prev: {
        xtremeShell = xtremeShell.packages.${system}.default;
        gprompt = gprompt.packages.${system}.default;
        nix4nvchad = nix4nvchad.packages.${system}.nvchad;
        astalCli = astal.packages.${system}.default;
        zen = zen.packages.${system}.default;
      };
      pkgs = import nixpkgs { 
        inherit system; 
        config.allowUnfree = true;
        overlays = [ overlay ]; 
      };
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
          extraSpecialArgs = inputs // {host = "desktop";};
          modules = [ ./homeManager/home.nix ];
        };
        laptop = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = inputs // {host = "laptop";};
          modules = [ ./homeManager/home.nix ];
        };
      };
    };
}
