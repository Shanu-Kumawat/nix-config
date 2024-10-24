{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    nodejs
    rustup
    gnumake
    elixir
  ];
}
