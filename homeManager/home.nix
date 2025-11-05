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
      showtime
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
      neovim
      neovide
      vencord
      nwg-look
      nautilus
      hyprshot
      fastfetch
      python314
      adwsteamgtk
      pika-backup
      wl-clipboard
      osu-lazer-bin
      gnome-keyring
      nixfmt-rfc-style
      gnome-text-editor

      # Astal
      vshell

      # matu
      matugen

      # polkit agent
      vagent

      # Custom apps
      # (callPackage ./derivations/kagent.nix {})
      vanana
      gprompt
    ]
    ++ printPkgs;

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
  };

  # Let home manager install and manage itself.
  programs.home-manager.enable = true;
}
