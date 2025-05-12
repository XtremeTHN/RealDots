{ pkgs, ... } @inputs:

{
  # Services
  services = {
    upower.enable = true;
    gvfs.enable = true;
    sshd.enable = true;
    flatpak.enable = true;
    input-remapper.enable =  true;
    printing = {
      enable = true;
      drivers = [
        pkgs.hplipWithPlugin
      ];
    };
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

    syncthing = {
      enable = true;
      openDefaultPorts = true;
    };

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };
  };

  # Custom services
}
