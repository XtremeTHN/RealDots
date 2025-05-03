{ config, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      # Hyprland variables
      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$fallbackMenu" = "fuzzel";
      "$menu" = "astal -t apprunner";
      "$mainMod" = "SUPER";

      monitor = ",1920x1080@60,auto,1";
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XCURSOR_SIZE,16"
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR,"
        "HYPRSHOT_DIR,/home/axel/Pictures/Screenshots"
      ];

      # Autostart
      exec-once = [
        "kagent"
        "swww-daemon"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;
        resize_on_border = false;
        allow_tearing = false;

        layout = "dwindle";
      };

      decoration = {
        rounding = 8;
        rounding_power = 2;

        active_opacity = 0.98;
        inactive_opacity = 0.8;

        shadow.enabled = true;
        blur.enabled = true;
      };

      misc = {
        vfr = true;
      };

      # slightly modified end-4 animations
      animations = {
        enabled = true;
        
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
        ];

        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "windowsIn, 1, 3, md3_decel, popin 60%"
          "windowsOut, 1, 3, md3_accel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          "layersIn, 1, 1.5, menu_decel, slide"
          "layersOut, 1, 1.6, menu_accel, slide"
          "fadeLayersIn, 1, 2, menu_decel"
          "fadeLayersOut, 1, 1.5, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      bind = [
        # Applications
        "$mainMod, T, exec, $terminal"
        "$mainMod, E, exec, $fileManager"
        "$mainMod SHIFT, R, exec, $fallbackMenu"
        "$mainMod, R, exec, $menu"

        ## Astal
        "$mainMod, B, exec, astal -t quicksettings"
        "$mainMod, N, exec, astal -t notification-center"

        ## Screenshots
        ", Print, exec, hyprshot -m region"
        "SHIFT, Print, exec, hyprshot -m window"

        ## Window behavior
        "$mainMod, V, togglefloating"
        "$mainMod, Q, killactive"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"

        ### Move window to a workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        ### Move focus with arrow keys
        "$mainMod, left, movefocus, h"
        "$mainMod, down, movefocus, j"
        "$mainMod, up, movefocus, k"
        "$mainMod, right, movefocus, l"

        ## Workspaces
        ### Workspace switching
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        ### Special workspace
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Exit hyprland
        "$mainMod SHIFT, M, exit"
      ];

      bindm = [
        "$mainMod, M, movewindow"
        "$mainMod, L, resizewindow"
      ];

      windowrulev2 = [
        "float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
        "float, title:^(Open File)(.*)$"
        "float, title:^(Select a File)(.*)$"
        "float, title:^(Choose wallpaper)(.*)$"
        "float, title:^(Open Folder)(.*)$"
        "float, title:^(Save As)(.*)$"
        "float, title:^(Library)(.*)$"
        "float, title:^(File Upload)(.*)$"
        
        "float, class:^(io.bassi.Amberol)$"
        "opacity 1 override, class:^(firefox)$"

        "keepaspectratio, title:^(Picture(-| )in(-| )[Pp]icture)$"
        "move 73% 72%,title:^(Picture(-| )in(-| )[Pp]icture)$ "
        "size 25%, title:^(Picture(-| )in(-| )[Pp]icture)$"
        "float, title:^(Picture(-| )in(-| )[Pp]icture)$"
        "pin, title:^(Picture(-| )in(-| )[Pp]icture)$"
      ];
    };
  };
}
