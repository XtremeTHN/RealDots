{ config, pkgs, ... } @args: let
  printPkgs = if args.host == "desktop" then [
    pkgs.hplip
  ] else [];
in {
  imports = [
    ./theming
    ./apps
    # ./wm/hyprland.nix
  ];

  home.username = "axel";
  home.homeDirectory = "/home/axel";
  home.stateVersion = "24.11"; # Do not change
  
  # Allow propietary programs
  nixpkgs.config.allowUnfree = true;
  

  # User packages
  home.packages = with pkgs; [
    (btop.override { rocmSupport = true; })
    morewaita-icon-theme
    adwaita-icon-theme
    teams-for-linux
    bibata-cursors
    podman-compose
    osu-lazer-bin
    hydralauncher
    lm_sensors
    parabolic
    distrobox
    amberol
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
    crun
    warp
    nixd
    file
    loupe
    unzip
    gradia
    vencord
    nwg-look
    nautilus
    hyprshot
    fastfetch
    python3Full
    pika-backup
    icon-library
    wl-clipboard
    youtube-music
    gnome-builder
    gnome-keyring
    nixfmt-rfc-style
    colloid-gtk-theme
    gnome-text-editor
    gnome-extension-manager
    
    winapps.winapps
    winapps.winapps-launcher


    vanana
  ] ++ printPkgs;
  
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
  };

  dconf.enable = true;
  
  # Let home manager install and manage itself.
  programs.home-manager.enable = true;
}
