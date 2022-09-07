{ config, pkgs, lib, ... }:

{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 24;
  };
  
  home.packages = [ pkgs.nordic pkgs.papirus-icon-theme ];
  
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
    };
    theme = {
      name = "Nordic";
    };

    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      package = pkgs.adwaita-qt;
      name = "Adwaita-dark";
    };
  };
}
