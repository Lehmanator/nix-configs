{
config
, lib
, pkgs
, ...
}:
{
  # Highlight colors (names, rbg, hex, etc.)
  plugins.nvim-colorizer = {
    enable = true;
    userDefaultOptions = {
      AARRGGBB = true;
      RGB = true;
      RRGGBB = true;
      RRGGBBAA = true;
      css = true;
      css_fn = true;
      hsl_fn = true;
      names = true;
      rgb_fn = true;
      sass.enable = true;
      tailwind = true; # null | bool | normal | lsp | both

      #mode = null;        # null | foreground | background | virtualtext
      #virtualText = " ";  # VT char when mode set to 'virtualtext'
      #sass.parsers = {};
    };
  };

}
