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
      vscode-langservers-extracted
      (pkgs.python313.withPackages(ps: with ps; [
        python-lsp-server
        ruff
      ]))
    ];
    extraPlugins = ''
      return {
        {"oxalica/nil"}
      }
    '';
  };
}
