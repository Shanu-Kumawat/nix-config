# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  # System-related imports
  systemImports = [
    ./hardware-configuration.nix
    ./system-conf/nvidia.nix
    ./system-conf/tlp.nix
    ./system-conf/intel.nix
    ./system-conf/gpg.nix
    ./system-conf/gnome.nix
    ./system-conf/obsidian.nix
    # ./system-conf/ollama.nix
  ];

  # Development-related imports
  developmentImports = [
    ./system-conf/development/languages.nix
    ./system-conf/development/nvim-lsp.nix
    ./system-conf/development/flutter.nix
    ./system-conf/development/cpp.nix
    ./system-conf/development/elixir.nix
    ./system-conf/development/rust.nix
  ];

in
{
  imports = systemImports ++ developmentImports;

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;

  };

  # Fixing clock
  time.hardwareClockInLocalTime = true;

  networking.hostName = "sk-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # networking.proxy.default = "http://edcguest:edcguest@172.31.102.29:3128/";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # For Electron Apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    # openmoji-color
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shanu = {
    isNormalUser = true;
    description = "Shanu Kumawat";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
    shell = pkgs.zsh;

  };

  # Install firefox.
  programs.firefox.enable = true;

  # Zsh
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    eza
    btop
    kitty
    jq
    ripgrep
    unzip
    gzip
    tmux
    micro
    wl-clipboard
    libsForQt5.qt5.qtwayland
    kdePackages.qtwayland
    tree
    blender
    gnome-network-displays
    appflowy
    code-cursor
    ollama-cuda

  ];

  # Enable nix-direnv
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.mtr.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  programs.ssh = {
    extraConfig = ''
      Host github.com
        User git
        IdentityFile ~/.ssh/id_ed25519_github

      # Uncomment if you need GitLab in the future
      # Host gitlab.com
      #   User git
      #   IdentityFile ~/.ssh/id_ed25519_gitlab
    '';
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.nameservers = [
    "8.8.8.8" # Google DNS (primary)
    "1.1.1.1" # Cloudflare DNS (secondary)
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
