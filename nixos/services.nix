{ pkgs, ... } @args:

let
  ifDesktop = (args.host == "desktop");
in {
  # Services
  services = {
    upower.enable = true;
    gvfs.enable = true;
    sshd.enable = true;
    flatpak.enable = true;
    input-remapper.enable = ifDesktop;
    power-profiles-daemon.enable = true;
    sysprof.enable = true;

    printing = {
      enable = ifDesktop;
      drivers = [
        pkgs.hplipWithPlugin
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
