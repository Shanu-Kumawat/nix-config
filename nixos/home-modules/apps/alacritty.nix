{
  config,
  pkgs,
  ...
}:

{
  enable = true;
  package = pkgs.alacritty;

  settings = {
    window = {
      padding = {
        x = 4;
        y = 4;
      };
      decorations = "full";
      opacity = 1;
      startup_mode = "Maximized";
      title = "Alacritty";
      dynamic_title = true;
      decorations_theme_variant = "None";
    };

    general = {
      import = [
        pkgs.alacritty-theme.tokyo_night
      ];

      live_config_reload = true;
    };

    font =
      let
        jetbrainsMono = style: {
          family = "JetBrainsMono Nerd Font";
          inherit style;
        };
      in
      {
        size = 14;
        normal = jetbrainsMono "Regular";
        bold = jetbrainsMono "Bold";
        italic = jetbrainsMono "Italic";
        bold_italic = jetbrainsMono "Bold Italic";
      };

    mouse.hide_when_typing = true;

    cursor = {
      style = "Block";
    };

    env = {
      TERM = "xterm-256color";
    };

  };
}
