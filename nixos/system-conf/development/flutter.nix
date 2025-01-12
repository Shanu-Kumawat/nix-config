{
  lib,
  pkgs,
  ...
}:

with lib;
let
  androidSdk = androidComposition.androidsdk;
  buildToolsVersionForAapt2 = "34.0.0";
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    cmdLineToolsVersion = "13.0";
    # toolsVersion = "26.1.1";
    platformToolsVersion = "35.0.2";
    buildToolsVersions = [
      buildToolsVersionForAapt2
      "33.0.1"
    ];
    platformVersions = [
      # "34"
      "35"
    ];
    includeEmulator = false;
    # emulatorVersion = "35.2.11";
    includeSystemImages = false;
    # systemImageTypes = [ "google_apis_playstore" ];
    # abiVersions = [ "x86_64" ];
    includeSources = false;
    includeNDK = false;
    # ndkVersions = [ "22.0.7026061" ]; # As mentioned in docs
    # cmakeVersions = [ "3.10.2" ]; # Added from docs
    useGoogleAPIs = false;
    useGoogleTVAddOns = false;
    extraLicenses = [
      "android-googletv-license"
      "android-sdk-arm-dbt-license"
      "android-sdk-license"
      "android-sdk-preview-license"
      "google-gdk-license"
      "intel-android-extra-license"
      "intel-android-sysimage-license"
      "mips-android-sysimage-license"
    ];
  };
in
{

  environment.systemPackages = with pkgs; [
    flutter
    androidSdk
    jdk17
    firebase-tools
    android-studio
    # qemu_kvm
    # cmake
    # ninja
    # pkg-config
  ];

  environment.variables = {
    # ANDROID_HOME = "${androidSdk}/libexec/android-sdk"; # Primary as per docs
    # ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk"; # Kept for compatibility
    # GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/${buildToolsVersionForAapt2}/aapt2";

    JAVA_HOME = pkgs.jdk17.home;
    QT_QPA_PLATFORM = "wayland;xcb"; # emulator related: try using wayland, otherwise fall back to X.

    # emulator related: vulkan-loader and libGL shared libs are necessary for hardware decoding
    # LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [
    #   pkgs.vulkan-loader
    #   pkgs.libGL
    # ]}";
  };

  nixpkgs.config = {
    android_sdk.accept_license = true;
    allowUnfree = true;
  };

  environment.shellInit = ''
    export PATH="$PATH":"$HOME/.pub-cache/bin"
    export PATH="$PATH":"$HOME/.config/flutter/bin"
  '';
  # export PATH=$PATH:${androidSdk}/libexec/android-sdk/platform-tools
  #   export PATH=$PATH:${androidSdk}/libexec/android-sdk/cmdline-tools/13.0/bin
  #   export PATH=$PATH:${androidSdk}/libexec/android-sdk/emulator

  services.udev.packages = [ pkgs.android-udev-rules ];

  programs.adb.enable = true;
  users.users."shanu".extraGroups = [
    "kvm"
    "adbusers"
  ];

}
