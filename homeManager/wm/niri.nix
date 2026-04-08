{ ... }:

{
  programs.niri.settings = let
    border-color = {
      from = "#A9C7FF";
      to = "#DCBCE1";
      angle = 45;
    };
  in {
    spawn-at-startup = [
      {
        command = ["awww-daemon"];
      }
      {
        command = ["xwayland-satellite"];
      }
      {
        command = ["rshell"];
      }
    ];
    outputs.HDMI-A-2 = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 164.999;
      };
    };

    binds = {
      "Mod+WheelScrollDown" = {
        action.focus-column-right = {};
      };
      "Mod+WheelScrollUp" = {
        action.focus-column-left = {};
      };

      "Mod+T" = {
        action.spawn = ["kitty"];
      };
      "Mod+R" = {
        action.spawn = ["fuzzel"];
      };
      "Mod+E" = {
        action.spawn = ["nautilus"];
      };

      "Mod+1" = {
        action.focus-workspace = 1;
      };
      "Mod+2" = {
        action.focus-workspace = 2;
      };
      "Mod+3" = {
        action.focus-workspace = 3;
      };
      "Mod+4" = {
        action.focus-workspace = 4;
      };
      "Mod+5" = {
        action.focus-workspace = 5;
      };
      "Mod+6" = {
        action.focus-workspace = 6;
      };
      "Mod+7" = {
        action.focus-workspace = 7;
      };
      "Mod+8" = {
        action.focus-workspace = 8;
      };
      "Mod+9" = {
        action.focus-workspace = 9;
      };

      "Mod+Shift+1" = {
        action.move-window-to-workspace = 1;
      };
      "Mod+Shift+2" = {
        action.move-window-to-workspace = 2;
      };
      "Mod+Shift+3" = {
        action.move-window-to-workspace = 3;
      };
      "Mod+Shift+4" = {
        action.move-window-to-workspace = 4;
      };
      "Mod+Shift+5" = {
        action.move-window-to-workspace = 5;
      };
      "Mod+Shift+6" = {
        action.move-window-to-workspace = 6;
      };
      "Mod+Shift+7" = {
        action.move-window-to-workspace = 7;
      };
      "Mod+Shift+8" = {
        action.move-window-to-workspace = 8;
      };
      "Mod+Shift+9" = {
        action.move-window-to-workspace = 9;
      };

      "Mod+BracketLeft" = {
        action.consume-or-expel-window-left = {};
      };
      "Mod+BracketRight" = {
        action.consume-or-expel-window-right = {};
      };
      "Mod+Shift+BracketLeft" = {
        action.set-column-width = "-10%";
      };
      "Mod+Shift+BracketRight" = {
        action.set-column-width = "+10%";
      };
      "Mod+Ctrl+BracketLeft" = {
        action.set-window-height = "-10%";
      };
      "Mod+Ctrl+BracketRight" = {
        action.set-window-height = "+10%";
      };

      "Mod+F" = {
        action.maximize-column = {};
      };
      "Mod+Shift+F" = {
        action.maximize-window-to-edges = {};
      };

      "Mod+D" = {
        action.switch-preset-window-width = {};
      };
      "Mod+Shift+D" = {
        action.switch-preset-window-height = {};
      };

      "Mod+V" = {
        action.toggle-window-floating = {};
      };

      "Mod+Slash" = {
        action.show-hotkey-overlay = {};
      };
    };

    layer-rules = [
      {
        matches = [
          {
            namespace = "^wallpaper$";
          }
        ];
        place-within-backdrop = true;
      }
    ];

    layout = {
      preset-column-widths = [
        {
          proportion = 1.0;
        }
        {
          proportion = 0.5;
        }
        {
          proportion = 0.33333;
        }
      ];
      preset-window-heights = [
        {
          proportion = 1.0;
        }
        {
          proportion = 0.5;
        }
        {
          proportion = 0.33333;
        }
      ];

      default-column-width = {
        proportion = 0.5;
      };

      focus-ring = {
        width = 0;
        active = {
          gradient = border-color;
        };
      };
      
      border = {
        enable = true;
        width = 2;
        active = {
          gradient = border-color;
        };
      };

      shadow = {
        enable = true;
      };
    };

    window-rules = [
      {
        geometry-corner-radius = {
          top-left = 6.0;
          top-right = 6.0;
          bottom-left = 6.0;
          bottom-right = 6.0;
        };
        clip-to-geometry = true;
      }

      {
        matches = [
          {
            app-id = "zen-beta$";
            title = "^Picture-in-Picture$";
          }
        ];

        open-floating = true;
      }
    ];
  };
}
