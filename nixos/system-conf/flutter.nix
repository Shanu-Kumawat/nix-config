{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.flutter;

  androidComposition = pkgs.androidenv.composeAndroidPackages {
    toolsVersion = "26.1.1";
    platformToolsVersion = "35.0.1";
    buildToolsVersions = [ "34.0.0" ];
    platformVersions = [ "34" ];
    abiVersions = [ "arm64-v8a" ];
    includeEmulator = true;
    emulatorVersion = "35.1.4";
    includeSystemImages = true;
    systemImageTypes = [ "google_apis_playstore" ];
    includeSources = false;
  };

  androidSdk = androidComposition.androidsdk;

in {
  options.programs.flutter = {
    enable = mkEnableOption "Flutter development environment";
    addToKvmGroup = mkEnableOption "Add user to KVM group for hardware acceleration";
    enableAdb = mkEnableOption "Enable ADB and add user to adbusers group";
    user = mkOption {
      type = types.str;
      description = "Username for Flutter development";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      flutter
      androidSdk
      jdk17
    ];

    environment.variables = {
      ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
      ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
    };

    nixpkgs.config = {
      android_sdk.accept_license = true;
      allowUnfree = true;
    };

    environment.shellInit = ''
      export PATH=$PATH:${androidSdk}/libexec/android-sdk/platform-tools
      export PATH=$PATH:${androidSdk}/libexec/android-sdk/cmdline-tools/latest/bin
      export PATH=$PATH:${androidSdk}/libexec/android-sdk/emulator
    '';


    programs.adb.enable = cfg.enableAdb;
    users.users.${cfg.user}.extraGroups = 
      (optional cfg.addToKvmGroup "kvm") ++
      (optional cfg.enableAdb "adbusers");

  };
}
