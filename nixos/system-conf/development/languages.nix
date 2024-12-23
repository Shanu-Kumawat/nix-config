{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nodejs
    python312Packages.pip
    python312
  ];
}
