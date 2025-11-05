{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # AstroNvim packages
    gcc
    unzip
    ripgrep
    gnumake
    tree-sitter
  ];

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.file."${config.xdg.configHome}/nvim/lua".source = ./nvchad/lua;
  home.file."${config.xdg.configHome}/nvim/.stylua.toml".source = ./nvchad/.stylua.toml;

  home.file."${config.xdg.configHome}/nvim/init.lua".source = ./nvchad/init.lua;
}
