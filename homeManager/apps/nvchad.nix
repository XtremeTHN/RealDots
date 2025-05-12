{ pkgs, config, ... } @inputs: 

{
  imports = [
    inputs.nix4nvchad.homeManagerModule
  ];

  programs.nvchad = {
    enable = true;
    hm-activation = true;
    extraPackages = with pkgs; [
      nil
    ];
    extraPlugins = ''
      return {
        {"oxalica/nil"}
      }
    '';
  };
}
