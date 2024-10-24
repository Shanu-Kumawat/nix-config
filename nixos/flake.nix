{
  description = "A Top Level NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Alacritty theme
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      alacritty-theme,
      ...
    }@inputs:
    {

      nixpkgs.overlays = [
        alacritty-theme.overlays.default
        #      templ.overlays.default
      ];

      nixosConfigurations.sk-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [

          ./configuration.nix
          ./system-conf/kanata.nix
          # Home Manager
          (
            { config, pkgs, ... }:
            {
              nixpkgs.overlays = [
                alacritty-theme.overlays.default
                #            inputs.templ.overlays.default
              ];
            }
          )

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.shanu = import ./home.nix;
          }

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix

        ];
      };
    };
}
