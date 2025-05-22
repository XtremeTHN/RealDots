{ config, pkgs, ... }:

{
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
    morewaita-icon-theme
    adwaita-icon-theme
    bibata-cursors
    simple-scan
    lm_sensors
    fuzzel
    vscode
    direnv
    hplip
    cargo
    glib
    grim
    swww
    gcc
    nil
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

  ];
  
  # Use with dotfiles
  #home.file {};

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
  };

  dconf.enable = true;
  
  # Let home manager install and manage itself.
  programs.home-manager.enable = true;
}
