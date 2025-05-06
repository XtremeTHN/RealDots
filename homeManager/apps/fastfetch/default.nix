{
  programs.fastfetch = {
    enable = true;
    settings = {
      display = {
        separator = "➜   ";
      };
      general = {
        multithreading = true;
      };
      logo = {
        padding = {
          right = 10;
          top = 2;
        };
        width = 40;
        height = 15;
        source = "~/.config/fastfetch/nixos.png";
        type = "kitty";
      };
      modules = [
        "break"
        {
          format = "                                {6}{7}{8}";
          type = "title";
        }
        "break"
        {
          format = "┌──────────────────────────────────────────────────────────────────────────────┐";
          type = "custom";
        }
        "break"
        {
          key = "     OS           ";
          keyColor = "green";
          type = "os";
        }
        {
          key = "    󰌢 Machine      ";
          keyColor = "cyan";
          type = "host";
        }
        {
          key = "     Kernel       ";
          keyColor = "blue";
          type = "kernel";
        }
        {
          key = "    󰅐 Uptime       ";
          keyColor = "green";
          type = "uptime";
        }
        {
          key = "     Packages     ";
          keyColor = "cyan";
          type = "packages";
        }
        {
          key = "     WM           ";
          keyColor = "blue";
          type = "wm";
        }
        {
          key = "     Shell        ";
          keyColor = "green";
          type = "shell";
        }
        {
          key = "     Terminal     ";
          keyColor = "cyan";
          type = "terminal";
        }
        {
          key = "     Font         ";
          keyColor = "blue";
          type = "terminalfont";
        }
        {
          key = "    󰻠 CPU          ";
          keyColor = "green";
          type = "cpu";
        }
        {
          key = "    󰍛 GPU          ";
          keyColor = "cyan";
          type = "gpu";
        }
        {
          key = "    󰑭 Memory       ";
          keyColor = "blue";
          type = "memory";
        }
        {
          key = "     Wifi         ";
          keyColor = "green";
          type = "wifi";
        }
        {
          compact = true;
          key = "    󰩟 Local IP     ";
          keyColor = "cyan";
          type = "localip";
        }
        "break"
        {
          format = "└──────────────────────────────────────────────────────────────────────────────┘";
          type = "custom";
        }
        "break"
        {
          block = {
            width = 10;
          };
          paddingLeft = 34;
          symbol = "circle";
          type = "colors";
        }
      ];
    };
  };
}