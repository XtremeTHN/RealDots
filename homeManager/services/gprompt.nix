{ pkgs, ... }:

{
  systemd.user.services.vala-gcr-prompt = {
    Unit = {
      Description = "vala-gcr-prompt";
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.gprompt}/bin/gprompt";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
