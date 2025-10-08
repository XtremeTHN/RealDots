{ pkgs, ... }:

{
  systemd.user.services.valant = {
    Unit = {
      Description = "Execute a command after graphical target is reached";
    };
    Install = {
      WantedBy = [ "graphical.target" ];
      PartOf = [ "graphical.target" ];
      After = [ "graphical.target" ];
    };

    Service = {
      Type = "exec";
      ExecStart = "${pkgs.flatpak}/bin/flatpak run ca.andyholmes.Valent --gapplication-service";
    };
  };
}
