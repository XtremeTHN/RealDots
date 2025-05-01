{ config, pkgs, ... }:

{
  imports = [
    ./theming.nix
    ./apps/bundle.nix
    ./wm/hyprland.nix
  ];

  home.username = "axel";
  home.homeDirectory = "/home/axel";
  home.stateVersion = "24.11"; # Do not change
  
  # Allow propietary programs
  nixpkgs.config.allowUnfree = true;

  # User packages
  home.packages = with pkgs; [
    bibata-cursors
    adwaita-icon-theme
    firefox
    fuzzel
    vscode
    glib
    swww
    
    warp
    nwg-look
    nautilus
    hyprshot
    fastfetch
    pika-backup
    python3Full
    wl-clipboard
    gnome-keyring

    # Custom apps
    (callPackage ./derivations/kagent.nix {})
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
