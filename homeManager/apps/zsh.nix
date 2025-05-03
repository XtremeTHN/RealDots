{ ... }:

{
  # Zsh config
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      rebuildSys = "sudo nixos-rebuild switch --flake $HOME/nix/";
      rebuildHome = "home-manager switch --flake $HOME/nix/";
    };
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    initContent = "eval $(starship init zsh)";
  };
}
