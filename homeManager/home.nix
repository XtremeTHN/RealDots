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
    ./wm/wayfire.nix
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
      hyprpaper
      nxloader
      (btop.override { rocmSupport = true; })
      morewaita-icon-theme
      adwaita-icon-theme
      teams-for-linux
      bibata-cursors
      prismlauncher
      hydralauncher
      lm_sensors
      libreoffice
      notion-app-enhanced
      parabolic
      distrobox
      showtime
      vesktop
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
      nixfmt
      neovim
      neovide
      vencord
      amberol
      nwg-look
      nautilus
      hyprshot
      fastfetch
      python314 
      adwsteamgtk
      pika-backup
      wl-clipboard
      icon-library
      osu-lazer-bin
      gnome-keyring
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
      svgtheme
    ]
    ++ printPkgs;

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
  };

  xdg.configFile."gtk-4.0/settings.ini".force = true;
  
  # Let home manager install and manage itself.
  programs.home-manager.enable = true;
}
