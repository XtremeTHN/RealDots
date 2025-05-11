{ config, pkgs, ... }:

{
  imports = [
    ./services.nix
    ./graphical/bundle.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  # Enable network
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

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
    extraGroups = [ 
      "networkmanager" 
      "wheel" 
      "video" # for gtkshell udev
    ];
  };

  # Allow users to connect to the nix daemon
  nix.settings.allowed-users = [ "@wheel" ];

  # System packages
  environment.systemPackages = with pkgs; [
    hplipWithPlugin
    neovim
    upower
    git
    
    zsh
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
  ];

  # Dconf config
  programs = {
    zsh.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        libvlc
        xorg.libX11
        xorg.libXi
        xorg.libXinerama
        xorg.libXrandr
        alsa-lib
        libGL
      ];
    };
    dconf = {
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
  };

  system.stateVersion = "24.11"; # Do not delete

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 1d";
  };
}
