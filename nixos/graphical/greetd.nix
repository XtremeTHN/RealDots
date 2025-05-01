{ pkgs, inputs, ... }:

let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  hyprland-session = "${pkgs.hyprland}/share/wayland-sessions";
in  {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} \
          --time\
          --remember\
          --remember-session\
          --sessions ${hyprland-session}
        ";
        user = "greeter";
      };
    };
  };

  # GNOME keyring
  security.pam.services.greetd.enableGnomeKeyring = true;
}
