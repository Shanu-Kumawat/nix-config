{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lua-language-server
    elixir-ls
    nixd
    nixfmt-rfc-style # formater
  ];
}
