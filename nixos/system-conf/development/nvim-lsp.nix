{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # lsp
    lua-language-server
    elixir-ls
    nixd

    # formater
    stylua
    nixfmt-rfc-style
  ];
}
