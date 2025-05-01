{ ... }:

{
  # Shell config
  programs.bash = {
    enable = true;
    shellAliases = let
      switchCmd = "switch --flake $HOME/nix/";
    in {
      rebuildSys = "sudo nixos-rebuild ${switchCmd}";
      rebuildHome = "home-manager ${switchCmd}";
    };
  };
}
