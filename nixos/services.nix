{ pkgs, ... }:

{
  # Services
  services = {
    upower.enable = true;
    gvfs.enable = true;
    sshd.enable = true;
    dbus = {
      enable = true;
      implementation = "broker";
    };

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };
  };

  # Custom services
}
