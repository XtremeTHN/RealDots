{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./services.nix
    ./graphical/bundle.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  # Enable network
  networking.networkmanager.enable = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "America/Monterrey";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # The user
  users.users.axel = {
    isNormalUser = true;
    description = "Axel Andres Valles Gonzalez";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };

  # Allow users to connect to the nix daemon
  nix.settings.allowed-users = [ "@wheel" ];

  # System packages
  environment.systemPackages = with pkgs; [
    neovim
    upower
    git
    
    zsh
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
  ];

  # Dconf config
  programs.dconf = {
    enable = true;
    profiles.user = {
      databases = [{
        lockAll = true;
        settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            gtk-theme = "adw-gtk3-dark-matugen";
          };
        };
      }];
    };
  };

  programs.zsh.enable = true;

  system.stateVersion = "24.11"; # Do not delete

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 1d";
  };
}
