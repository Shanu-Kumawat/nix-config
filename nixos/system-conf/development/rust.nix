{
  pkgs,
  ...
}:
{
  config = {
    environment.systemPackages = with pkgs; [
      # Core Rust toolchain with extensions
      (rust-bin.stable.latest.default.override {
        extensions = [
          "rust-src"
          "rust-analyzer"
        ];
      })

      ## Cargo Extensions

      # Dependency management
      cargo-edit # Adds `cargo add/rm/upgrade` commands for managing dependencies

      # Development workflow
      cargo-watch # Watches files and runs commands on changes (hot reload)

      # Security and maintenance
      cargo-audit # Checks dependencies for security vulnerabilities
      cargo-outdated # Shows which dependencies are outdated

      # Debugging and profiling
      cargo-expand # Shows result of macro expansion
      cargo-flamegraph # Generates flamegraph for performance analysis

      # Testing
      cargo-tarpaulin # Code coverage reporting

      ## System Dependencies

      # Build essentials
      pkg-config # Helps find installed libraries

      # SSL Support - choose one:
      openssl.dev # Development files for OpenSSL (headers + static libs)
      # openssl        # Runtime only (dynamic libs)

      ## Debugging Tools

      gdb # GNU Debugger
      lldb # LLVM Debugger (usually better for Rust)
    ];

    # Optional but recommended environment variables
    environment.variables = {
      # Enable backtrace by default
      # RUST_BACKTRACE = "1";

      # For projects using OpenSSL
      OPENSSL_DIR = "${pkgs.openssl.dev}";
      OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
      OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
    };
  };
}
