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
      glfw
      SDL2
      SDL2.dev
      libGL

      # X11 Development Libraries for imgui
      xorg.libX11
      xorg.libX11.dev
      xorg.libXext
      xorg.libXext.dev
      xorg.libXrandr
      xorg.libXrandr.dev
      xorg.libXinerama
      xorg.libXinerama.dev
      xorg.libXcursor
      xorg.libXcursor.dev
      xorg.libXi
      xorg.libXi.dev
      xorg.xorgproto

      # Mathematics and 3D
      glm
      assimp

      # UI library
      # imgui clone from docking branch

      # Development Tools
      # valgrind
      # renderdoc
    ];

    environment.variables = {
      PKG_CONFIG_PATH = "${pkgs.glfw}/lib/pkgconfig:${pkgs.SDL2.dev}/lib/pkgconfig:${pkgs.imgui}/lib/pkgconfig:$PKG_CONFIG_PATH";
      LD_LIBRARY_PATH = "${pkgs.SDL2}/lib:/run/opengl-driver/lib:/run/opengl-driver-32/lib:${
        pkgs.lib.makeLibraryPath [
          pkgs.vulkan-loader
          pkgs.libGL
        ]
      }";
      CPLUS_INCLUDE_PATH = "${pkgs.xorg.xorgproto}/include:${pkgs.xorg.libX11.dev}/include:${pkgs.SDL2.dev}/include";
      CMAKE_PREFIX_PATH = "${pkgs.SDL2.dev}:${pkgs.SDL2}";
    };
  };
}
