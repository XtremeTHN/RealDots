{ pkgs, ... }:

{
  wayland.windowManager.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [
      wcm
      wayfire-plugins-extra
    ];
  };
}
