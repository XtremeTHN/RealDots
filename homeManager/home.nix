{ config, pkgs, ... } @args: let
  printPkgs = if args.host == "desktop" then [
    pkgs.hplip
  ] else [];
in {
  imports = [
    ./theming
    ./apps
    ./wm/hyprland.nix
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
    warp
    nixd
    file
    loupe
    nwg-look
    vencord
    nautilus
    hyprshot
    fastfetch
    pika-backup
    python3Full
    wl-clipboard
    gnome-keyring
    nixfmt-rfc-style

    # Astal
    astalCli
    xtremeShell

    # matu
    matugen

    # Custom apps
    (callPackage ./derivations/kagent.nix {})
    (callPackage ./derivations/adw-gtk3-md.nix {
      configDir = config.xdg.configHome;
    })
    gprompt
  ] ++ printPkgs;
  
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
  };

  dconf.enable = true;
  
  # Let home manager install and manage itself.
  programs.home-manager.enable = true;
}
