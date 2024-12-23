{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = {
    environment.systemPackages = with pkgs; [
      # Base Rust toolchain
      rustc
      cargo
      rust-analyzer
      rustfmt
      clippy
      rustPlatform.rustLibSrc

      # Additional development tools
      cargo-edit # adds cargo add, cargo rm, cargo upgrade commands
      cargo-watch # for watch-and-rebuild functionality
      cargo-audit # for security audits
      cargo-expand # for viewing macro expansions
      cargo-flamegraph # for performance profiling
      cargo-outdated # for checking outdated dependencies
      cargo-tarpaulin # for code coverage

      # Build dependencies commonly needed
      pkg-config
      openssl.dev

      # Debugging tools
      gdb # for debugging Rust programs
      lldb # alternative debugger
    ];

    environment.variables = {
      RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
      # RUST_BACKTRACE = "1"; # Enable better error backtraces
    };
  };
}
