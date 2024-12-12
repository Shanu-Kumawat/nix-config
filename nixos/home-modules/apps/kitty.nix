{ pkgs, config, ... }:

{
  enable = true;

  # Font configuration
  font = {
    name = "JetBrains Mono";
    # package = pkgs.jetbrains-mono;
    size = 14;
  };

  theme = "Tokyo Night";

  # Kitty settings
  settings = {
    # Window and UI settings
    window_padding_width = 4;
    background_opacity = "0.9";
    hide_window_decorations = "yes";
    confirm_os_window_close = 0;

    # # Color scheme
    # background = "#101319";
    # foreground = "#f4f3ee";
    # cursor_color = "#f4f3ee";
    #
    # # Color palette
    # color0 = "#171b24"; # Black
    # color1 = "#E34F4F"; # Red
    # color2 = "#69bfce"; # Green
    # color3 = "#e37e4f"; # Yellow
    # color4 = "#5679E3"; # Blue
    # color5 = "#956dca"; # Magenta
    # color6 = "#5599E2"; # Cyan
    # color7 = "#f4f3ee"; # White
    #
    # # Bright colors
    # color8 = "#3A435A"; # Bright Black
    # color9 = "#DE2B2B"; # Bright Red
    # color10 = "#56B7C8"; # Bright Green
    # color11 = "#DE642B"; # Bright Yellow
    # color12 = "#3E66E0"; # Bright Blue
    # color13 = "#885AC4"; # Bright Magenta
    # color14 = "#3F8CDE"; # Bright Cyan
    # color15 = "#DDDBCF"; # Bright White

  };

  keybindings = {
    "ctrl+shift+t" = "new_tab";
    "ctrl+shift+w" = "close_tab";
    "ctrl+right" = "next_tab";
    "ctrl+left" = "previous_tab";
  };

  shellIntegration = {
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
