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

      default-column-width = {
        proportion = 0.5;
      };

      focus-ring = {
        width = 0;
        active = {
          gradient = {} // border-color;
        };
      };
      
      border = {
        enable = true;
        active = {
          gradient = {} // border-color;
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
    ];
  };
}
