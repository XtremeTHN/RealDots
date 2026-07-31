{ pkgs, config, ... }: let
  adw-gtk-matugen = (pkgs.callPackage ../derivations/adw-gtk-matugen.nix {
    configDir = config.xdg.configHome;
  });
in {
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4 = {
      extraCss = "@import url(\"file://${adw-gtk-matugen}/share/themes/adw-gtk-matugen/gtk-4.0/gtk.css\");";
      theme = {
        name = "adw-gtk-matugen";
      };
    };

    iconTheme = {
      package = pkgs.morewaita-icon-theme;
      name = "MoreWaita";
    };

    font = {
      name = "Adwaita Sans";
      size = 11;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "adw-gtk-matugen";
      color-scheme = "prefer-dark";
    };
  };
}
