{
  description = "System config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vshell = {
      url = "github:xtremethn/vshell";
    };
    gprompt.url = "github:xtremethn/gprompt";
    vagent.url = "github:xtremethn/vagent";
    vanana.url = "github:xtremethn/vanana";
    gtk-utils.url = "github:xtremethn/hyprgtkutils";

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

  outputs =
    {
      nixpkgs,
      home-manager,
      nix4nvchad,
      gtk-utils,
      gprompt,
      vanana,
      vagent,
      vshell,
      zen,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      overlay = final: prev: {
        vshell = vshell.packages.${system}.default;
        gprompt = gprompt.packages.${system}.default;
        nix4nvchad = nix4nvchad.packages.${system}.nvchad;
        zen = zen.packages.${system}.default;
        vagent = vagent.packages.${system}.default;
        vanana = vanana.packages.${system}.default;
        hyprland-qtutils = gtk-utils.packages.${system}.default;
      };
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          rocmSupport = true;
        };
        overlays = [ overlay ];
      };

      deskSet = {
        host = "desktop";
      };
      lapSet = {
        host = "laptop";
      };
    in
    {
      nixosConfigurations = {
        # Change host with --flake ./#HOSTNAME
        desktop = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = deskSet;
          modules = [
            ./hosts/desktop
            ./nixos/configuration.nix
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = lapSet;
          modules = [
            ./hosts/laptop
            ./nixos/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        desktop = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = inputs // deskSet;
          modules = [
            ./homeManager/home.nix
          ];
        };
        laptop = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = inputs // lapSet;
          modules = [
            ./homeManager/home.nix
          ];
        };
      };
    };
}
