{
  home.file.".config/fastfetch/ascii.txt".source = ./ascii.txt;
  programs.fastfetch = {
    enable = true;
    settings = {
      display = {
        separator = " ";
      };
      logo = {
        padding = {
          right = 6;
          top = 2;
        };
        source = "~/.config/fastfetch/ascii.txt";
      };
      modules = [
        "break"
        "break"
        {
          keyWidth = 10;
          type = "title";
        }
        "break"
        {
          key = " ";
          keyColor = "33";
          type = "os";
        }
        {
          key = " ";
          keyColor = "33";
          type = "kernel";
        }
        {
          key = " ";
          keyColor = "33";
          type = "packages";
        }
        {
          key = " ";
          keyColor = "33";
          type = "shell";
        }
        {
          key = " ";
          keyColor = "33";
          type = "terminal";
        }
        {
          key = " ";
          keyColor = "33";
          type = "wm";
        }
        {
          key = " ";
          keyColor = "33";
          type = "uptime";
        }
        {
          key = "󰝚 ";
          keyColor = "33";
          type = "media";
        }
        "break"
        "colors"
        "break"
        "break"
      ];
    };
  };
}
