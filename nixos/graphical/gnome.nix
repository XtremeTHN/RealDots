{ environment, pkgs, ... }:

{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    totem
    gnome-music
    gnome-calendar
    gnome-contacts
    geary
    gnome-maps
    epiphany
  ];

  environment.systemPackages = with pkgs.gnomeExtensions; [
    blur-my-shell
    appindicator
    dash2dock-lite
  ];
}
