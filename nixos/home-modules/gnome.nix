{ pkgs, ... }:

{
  dconf.enable = true;
  dconf.settings = {
  #  "org/gnome/desktop/interface" = {                  Didn't Works
  #    scaling-factor = lib.hm.gvariant.mkUint32 2;
  #    text-scaling-factor = 1.0;
  #  };
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "${pkgs.gnomeExtensions.gsconnect.extensionUuid}"
        "blur-my-shell@aunetx"
      ];
    };
  };

  # Install GNOME extensions
  home.packages = with pkgs.gnomeExtensions; [
    gsconnect
    blur-my-shell
  ];

  # If you want to configure extension settings, you can uncomment and adjust these:
  # dconf.settings."org/gnome/shell/extensions/blur-my-shell" = {
  #   brightness = 0.75;
  #   noise-amount = 0;
  # };
}
