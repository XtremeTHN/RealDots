{ home, config, lib, pkgs, ... }: let
  adwaitaScalablePath = "${pkgs.adwaita-icon-theme}/share/icons/Adwaita/scalable";
  adwaitaPlacesPath = "${adwaitaScalablePath}/places";
  adwaitaInodePath = "${adwaitaScalablePath}/mimetypes/inode-directory.svg";
  
  matugenConf = {
    config = {
      wallpaper = {
        arguments = [
          "img"
          "--transition-type"
          "center"
        ];
        command = "swww";
      };
    };
    templates = {
      astal = {
        input_path = "~/.config/matugen/templates/astal.tmp";
        output_path = "~/.config/shell/scss/colors.scss";
      };
      fuzzel = {
        input_path = "~/.config/matugen/templates/fuzzel.tmp";
        output_path = "~/.config/fuzzel/fuzzel.ini";
      };
      gtk3 = {
        input_path = "~/.config/matugen/templates/gtk.tmp";
        output_path = "~/.config/gtk-3.0/colors.css";
      };
      gtk4 = {
        input_path = "~/.config/matugen/templates/gtk4.tmp";
        output_path = "~/.config/gtk-4.0/colors.css";
        post_hook = "systemctl restart vala-gcr-prompt vala-polkit-authentication-agent --user && vshell -r";
      };
      svgtheme = {
        input_path = "~/.config/matugen/templates/svgtheme.tmp";
        output_path = "~/.config/svgtheme/config.json";
        post_hook = "svgtheme ${adwaitaPlacesPath} -o ~/.icons/Adwaita/scalable/places && svgtheme ${adwaitaInodePath} -o ~/.icons/Adwaita/scalable/mimetypes";
      };
      hyprland = {
        input_path = "~/.config/matugen/templates/hypr_colors.tmp";
        output_path = "~/.config/hypr/colors.conf";
      };
      kitty = {
        input_path = "~/.config/matugen/templates/kitty.tmp";
        output_path = "~/.config/kitty/matugen.conf";
        post_hook = "pgrep --signal SIGUSR1 kitty; exit 0";
      };
      nvim = {
        input_path = "~/.config/matugen/templates/nvim.tmp";
        output_path = "~/.local/share/nvim/lazy/base46/lua/base46/themes/chadwal.lua";
      };
      vscode = {
        input_path = "~/.config/matugen/templates/vscode.tmp";
        output_path = "~/.cache/wal/colors.json";
      };
      vscode_colors = {
        input_path = "~/.config/matugen/templates/vscode_colors.tmp";
        output_path = "~/.cache/wal/colors";
      };
    };
  };
in {
  home.file."${config.xdg.configHome}/matugen/templates".source = ./templates;
  home.file."${config.xdg.configHome}/matugen/config.toml".text = pkgs.nix-std.serde.toTOML matugenConf;
  home.file."Pictures/Wallpapers".source = ./wallpapers;
}
