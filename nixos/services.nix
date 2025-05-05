{ pkgs, ... }:

{
  # Services
  services = {
    upower.enable = true;
    gvfs.enable = true;
    sshd.enable = true;
    flatpak.enable = true;

    # Custom
    udev = {
      packages = [
        pkgs.xtremeShell
      ];
    };
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
