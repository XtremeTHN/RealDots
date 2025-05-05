{ pkgs, home, config, ... } @inputs: let 
  matugenFiles = config.programs.matugen.theme.files;
  gtkTheme = ".themes/adw-gtk3-dark-matugen";
in {
  imports = [
    inputs.matugen.nixosModules.default
  ];

  programs.matugen = {
    enable = true;
    variant = "dark";
    jsonFormat = "hex";

    config = {
      wallpaper = {
        arguments = [ "img" "--transition-type" "center" ];
        command = "swww";
      };
    };
    templates = {
      astal = {
        input_path = ./templates/astal.tmp;
        output_path = "astal-colors.scss";
      };
      fuzzel = {
        input_path = ./templates/fuzzel.tmp;
        output_path = "fuzzel.ini";
      };
      gtk3 = {
        input_path = ./templates/gtk.tmp;
        output_path = "colors-gtk3.css";
      };
      gtk4 = {
        input_path = ./templates/gtk.tmp;
        output_path = "colors-gtk4.css";
      };
      hyprland = {
        input_path = ./templates/hypr_colors.tmp;
        output_path = "colors.conf";
      };
      kitty = {
        input_path = ./templates/kitty.tmp;
        output_path = "matugen-kitty.conf";
      };
      # nvim = {
      #   input_path = "./templates/nvim.tmp";
      #   output_path =
      #     "~/.local/share/nvim/lazy/base46/lua/base46/themes/chadwal.lua";
      #   post_hook = "killall -SIGUSR1 nvim; exit 0";
      # };
    };
  };
  
  home.file = {
    "${config.xdg.configHome}/shell/scss/colors.scss".source = "${matugenFiles}/astal-colors.scss";
    "${config.xdg.configHome}/fuzzel/fuzzel.ini".source = "${matugenFiles}/fuzzel.ini";
    "${config.xdg.configHome}/hypr/colors.conf".source = "${matugenFiles}/colors.conf";
    "${config.xdg.configHome}/kitty/matugen.conf".source = "${matugenFiles}/matugen-kitty.conf";
  };
  # home.file = {
  #   "${gtkTheme}/gtk-3.0/assets/colors.css".source = "${config}/colors-gtk3.css";
  #   "${gtkTheme}/gtk-4.0/assets/colors.css".source = "${config}/colors-gtk4.css";
  # };
}