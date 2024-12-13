{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    obsidian
  ];

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "shanu"; # Explicitly set your username
    dataDir = "/home/shanu"; # Base directory for Syncthing

    settings = {
      devices = {
        "oneplus" = {
          id = "DZFU3WI-KK3HAYY-ERL7EBL-KS2WEDC-J5JXJ2A-LJC73EJ-TS5TRGK-2LMZOQA";
        };
      };
      folders = {
        "Obsidian" = {
          path = "/home/shanu/Documents/Obsidian/";
          devices = [ "oneplus" ];
          type = "sendreceive"; # Allows bidirectional sync
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600"; # Cleanup every hour
              maxAge = "2592000"; # Keep versions for 30 days
            };
          };
        };
      };
    };
  };

}
