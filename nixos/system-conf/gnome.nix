{ pkgs, ... }:

{
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  environment.gnome.excludePackages = with pkgs; [
    # evince
    # file-roller
    geary
    # gnome-disk-utility
    # seahorse
    # sysprof
    # gnome-bluetooth
    # gnome-color-manager
    # gnome-control-center
    # gnome-shell-extensions
    gnome-tour # GNOME Shell detects the .desktop file on first log-in.
    gnome-user-docs
    # glib # for gsettings program
    # gnome-menus
    # gtk3.out # for gtk-launch program
    # xdg-user-dirs # Update user dirs as described in https://freedesktop.org/wiki/Software/xdg-user-dirs/
    # xdg-user-dirs-gtk # Used to create the default bookmarks
    #
    # baobab
    epiphany
    gnome-text-editor
    # gnome-calculator
    # gnome-calendar
    # gnome-characters
    # gnome-clocks
    gnome-console
    gnome-contacts
    # gnome-font-viewer
    gnome-logs
    gnome-maps
    # gnome-music
    # gnome-system-monitor
    gnome-weather
    # loupe
    # nautilus
    # gnome-connections
    # simple-scan
    # snapshot
    # totem
    yelp
  ];
}