{ pkgs, ... }:

{
  systemd.user.services.vala-polkit-authentication-agent = {
    Unit = {
      Description = "vala-polkit-authentication-agent";
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.vagent}/bin/vagent";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
