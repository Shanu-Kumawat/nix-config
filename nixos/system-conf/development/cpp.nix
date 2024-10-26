{ pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      # Core Development Tools
      gcc # GNU Compiler Collection
      cmake # Build system
      gnumake # Build automation
      pkg-config # Compilation flags helper
      ninja # Fast build system, works well with CMake
      clang-tools # Additional C++ tools and analysis

      # OpenGL/Graphics Libraries
      glfw # GLFW with Wayland support
      # python312Packages.glad2
      # glew # OpenGL extension loader |  will use glad
      libGL # OpenGL library
      # mesa

      # Mathematics and 3D
      glm # OpenGL Mathematics library
      assimp # 3D model loading

      # Development Tools
      # gdb            # GNU Debugger
      valgrind # Memory debugging
      renderdoc # Graphics debugging

    ];

    # Add pkg-config paths
    environment.variables = {
      PKG_CONFIG_PATH = "${pkgs.glfw}/lib/pkgconfig:${pkgs.libGL}/lib/pkgconfig:$PKG_CONFIG_PATH";
      LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib";
    };
  };
}
