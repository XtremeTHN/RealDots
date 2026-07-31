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
    ./wm/niri.nix
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
      swaybg
      xwayland-satellite
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
      awww
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
      nwg-look
      nautilus
      hyprshot
      waycorner
      fastfetch
      python314 
      quickshell
      # nxthumbnail
      adwsteamgtk
      pika-backup
      wl-clipboard
      icon-library
      authenticator
      gnome-keyring
      gnome-text-editor

      # Desktop Shell
      rshell

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
