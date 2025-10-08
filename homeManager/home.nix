{ config, pkgs, ... }@args:
let
  printPkgs =
    if args.host == "desktop" then
      [
        pkgs.hplip
      ]
    else
      [ ];
in
{
  imports = [
    ./theming
    ./apps
    ./wm/hyprland.nix
    ./services
    args.nix-flatpak.homeManagerModules.nix-flatpak

  ];

  home.username = "axel";
  home.homeDirectory = "/home/axel";
  home.stateVersion = "24.11"; # Do not change

  # Allow propietary programs
  nixpkgs.config.allowUnfree = true;

  # User packages
  home.packages =
    with pkgs;
    [
      (btop.override { rocmSupport = true; })
      morewaita-icon-theme
      adwaita-icon-theme
      teams-for-linux
      bibata-cursors
      hydralauncher
      lm_sensors
      parabolic
      distrobox
      fuzzel
      vscode
      direnv
      cargo
      glib
      grim
      swww
      gcc
      zen

      bat
      eza
      warp
      nixd
      file
      dconf
      loupe
      nwg-look
      vencord
      nautilus
      hyprshot
      fastfetch
      pika-backup
      python314
      wl-clipboard
      osu-lazer-bin
      gnome-keyring
      nixfmt-rfc-style

      # Astal
      xtremeShell

      # matu
      matugen

      # polkit agent
      kagent

      # Custom apps
      # (callPackage ./derivations/kagent.nix {})

      gprompt
    ]
    ++ printPkgs;

  services.flatpak.packages = [
    {
      flatpakref = "https://valent.andyholmes.ca/valent.flatpakref";
      sha256 = "1v5xxaszxir44ymihwrb8yj2rg9bsz96khl5if0si5xnjcja3ygh";
    }
    "com.usebottles.Bottles"
    "com.github.tchx84.Flatseal"
    "org.vinegarhq.Sober"
    "re.sonny.Workbench"
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
  };

  # Let home manager install and manage itself.
  programs.home-manager.enable = true;
}
