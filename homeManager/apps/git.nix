{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "Axel";
      email = "nigthmaresans2@gmail.com";
    };
  };
  programs.gh.enable = true;
}
