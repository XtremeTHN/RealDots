{ lib, ... }:

{
  programs.kitty.enable = true;
  programs.kitty.settings = lib.mkForce {
    font_family = "JetBrainsMono Nerd Font";
    window_padding_width = 10;
    enable_audio_bell = "no";
    background_opacity = 0.93;
    allow_remote_control = true;
  };
}
