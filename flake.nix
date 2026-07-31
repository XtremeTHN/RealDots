{
  description = "System config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # rshell = {
    #   url = "github:xtremethn/RShell";
    # };
    nxthumbnail = {
      url = "github:xtremethn/nxthumbnailer";
    };
    gprompt.url = "github:xtremethn/gprompt";
    vagent.url = "github:xtremethn/vagent";
    vanana.url = "github:xtremethn/vanana";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    svgtheme = {
      url = "github:XtremeTHN/SvgTheme";
    };
    silentSDDM = {
      url = "github:XtremeTHN/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-std.url = "github:chessai/nix-std";
    nvchad-starter = {
      url = "github:XtremeTHN/nvchad-starter";
      flake = false;
    };
    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nvchad-starter.follows = "nvchad-starter";
    };
    nxloader = {
      url = "github:xtremethn/nxloader";
    };
  };

  outputs =
    {
      nixpkgs,
      nix-index-database,
      nxthumbnail,
      lanzaboote,
      home-manager,
      nix4nvchad,
      silentSDDM,
      svgtheme,
      nxloader,
      gprompt,
      nix-std,
      vanana,
      vagent,
      # rshell,
      zen,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      overlay = final: prev: {        
        # rshell = rshell.packages.${system}.default;
        gprompt = gprompt.packages.${system}.default;
        nix4nvchad = nix4nvchad.packages.${system}.nvchad;
        zen = zen.packages.${system}.default;
        vagent = vagent.packages.${system}.default;
        vanana = vanana.packages.${system}.default;
        svgtheme = svgtheme.packages.${system}.default;
        nix-std = nix-std.lib;
        nxloader = nxloader.packages.${system}.default;
        # nxthumbnail = nxthumbnail.packages.${system}.default;
        silentSDDM = silentSDDM.packages.${system}.default.override {
          theme = "default";
          theme-overrides = {
            "LoginScreen" = {
              background = "ori.jpeg";
            };
            "LockScreen" = {
              background = "ori.jpeg";
            };
          };
        };
      };
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
          overlay
        ];
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
            lanzaboote.nixosModules.lanzaboote
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
            nix-index-database.homeModules.default
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
