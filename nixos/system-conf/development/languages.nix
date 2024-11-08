{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nodejs
    rustup
    python312Packages.pip
    python312
  ];
}
