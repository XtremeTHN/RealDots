{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Axel";
    userEmail = "nigthmaresans2@gmail.com";
  };
  programs.gh.enable = true;
}
