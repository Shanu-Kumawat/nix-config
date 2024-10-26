{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nodejs
    rustup
    elixir
  ];
}
