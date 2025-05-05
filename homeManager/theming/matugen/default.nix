{ home, config, ... }: 

{
  home.file."${config.xdg.configHome}/matugen/templates".source = ./templates;
  home.file."${config.xdg.configHome}/matugen/config.toml".source = ./config.toml;
}