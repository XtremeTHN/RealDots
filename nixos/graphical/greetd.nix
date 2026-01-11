{ pkgs, inputs, ... }:

let
  hyprland-session = "${pkgs.hyprland}/share/wayland-sessions";
in
{
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;
    theme = pkgs.silentSDDM.pname;
    extraPackages = pkgs.silentSDDM.propagatedBuildInputs;
  };

  # GNOME keyring
  security.pam.services.greetd.enableGnomeKeyring = true;
}
