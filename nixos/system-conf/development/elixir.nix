# elixir-phoenix.nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    elixir
    erlang
    nodejs # For Phoenix assets
    inotify-tools

    # SQLite tools
    sqlite
    sqlite-interactive # Command line interface
    # sqlitebrowser # GUI browser (optional)
  ];

  # Set up environment variables for Elixir and Phoenix
  environment.sessionVariables = {
    MIX_HOME = "${config.users.users.shanu.home}/.mix";
    HEX_HOME = "${config.users.users.shanu.home}/.hex";
  };

  # PostgreSQL setup
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    # enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      # TYPE  DATABASE        USER            ADDRESS         METHOD
      local   all            all                             trust
      host    all            all             127.0.0.1/32    trust    # IPv4 localhost
      host    all            all             ::1/128         trust    # IPv6 localhost
    '';
  };

}
