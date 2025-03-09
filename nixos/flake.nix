{
  description = "A Top Level NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Alacritty Theme
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";

    # Grub Theme
    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";

    # Rust overlay
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      alacritty-theme,
      nixos-grub-themes,
      rust-overlay,
      ...
    }@inputs:
    {
      nixpkgs.overlays = [
        alacritty-theme.overlays.default
        rust-overlay.overlays.default
      ];

      nixosConfigurations.sk-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nixos-grub-themes; };
        modules = [

          ./configuration.nix
          ./system-conf/development/rust.nix

          # Home Manager
          (
            { config, pkgs, ... }:
            {
              nixpkgs.overlays = [
                alacritty-theme.overlays.default
                rust-overlay.overlays.default
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
