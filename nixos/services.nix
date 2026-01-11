{ pkgs, ... }@args:

let
  ifDesktop = (args.host == "desktop");
in
{
  # Services
  services = {
    upower.enable = true;
    gvfs.enable = true;
    sshd.enable = true;
    flatpak.enable = true;
    input-remapper.enable = ifDesktop;
    power-profiles-daemon.enable = true;

    printing = {
      enable = ifDesktop;
      drivers = [
        pkgs.hplipWithPlugin
      ];
    };
    # Custom
    # udev = {
    #   packages = [
    #     pkgs.xtremeShell
    #   ];
    # };
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
  # from https://github.com/thomX75/nixos-modules/blob/main/SDDM/sddm-avatar.nix
  systemd.services."sddm-avatar" = {
    description = "Service to copy or update users Avatars at startup.";
    wantedBy = [ "multi-user.target" ];
    before = [ "sddm.service" ];
    script = ''
      for user in /home/*; do

        username=$(basename "$user")
        icon_source="$user/.face.icon"
        icon_dest="/var/lib/AccountsService/icons/$username"

        if [ -f "$icon_source" ]; then
          if [ ! -f "$icon_dest" ] || ! cmp -s "$icon_source" "$icon_dest"; then
            rm -f "$icon_dest"
            cp -L "$icon_source" "$icon_dest"
          fi
        fi

      done
    '';
    serviceConfig = {
      Type = "simple";
      User = "root";
      StandardOutput = "journal+console";
      StandardError = "journal+console";
    };
  };
}
