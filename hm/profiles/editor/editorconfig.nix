{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [ ];

  # TODO: Add editorconfig plugin to editors
  editorconfig.enable = true;
  editorconfig.settings = {
    "*" = {
      charset = "utf-8"; # TODO: Handle Windows/MacOS/Android
      end_of_line = "lf";
      trim_trailing_whitespace = true;
      insert_final_newline = true;
      max_line_width = 120;
      indent_style = "space";
      indent_size = 2;
    };
  };
}
