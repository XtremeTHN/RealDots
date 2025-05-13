{ ... }:

{
  # Zsh config
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza --icons";
    };
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    initContent = "eval $(starship init zsh)";
  };
}
