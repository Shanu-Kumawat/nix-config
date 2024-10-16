{ config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "shanu";
  home.homeDirectory = "/home/shanu";

  xdg.enable = true;
  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/home/shanu/.dotfiles/config/nvim";


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    tmux = (import ./home-modules/apps/tmux.nix { inherit pkgs; });
    zsh = (import ./home-modules/shell/zsh.nix { inherit config pkgs; });
    neovim = (import ./home-modules/apps/neovim.nix { inherit config pkgs; });
    git = (import ./home-modules/apps/git.nix { inherit config pkgs; });
    alacritty = (import ./home-modules/apps/alacritty.nix { inherit config pkgs; });
  #  firefox = (import ./firefox.nix { inherit pkgs; });
    zoxide = (import ./home-modules/apps/zoxide.nix { inherit pkgs; });
    fzf = (import ./home-modules/apps/fzf.nix { inherit pkgs; });
  };

  imports = [ (import ./home-modules/gnome.nix { inherit pkgs; }) ];

}
