{ inputs
, config
, lib
, pkgs

, border ? true

, squared ? true
, rounded ? false

, singleline ? true
, doubleline ? false

, compact ? false
, transparent ? true
, float ? true

, ...
}:
{
  imports = [
  ];

  programs.nixvim.plugins =
    let
      nvim_open_win =
        if !border then "none" else
        if rounded then "rounded" else
        if doubleline then "double" else "single"; # See :h nvim_open_win()

    in
    {

      floaterm = {
        # Floating terminal
        opener = "split"; # Options: edit | split | vsplit | tabe | drop
        position = "auto"; # wintype=split: leftabove | aboveleft | rightbelow | belowright | topleft | botright
        wintype = "float"; # wintype=float: top | bottom | left | right | topleft | topright | bottomleft | bottomright | center | auto (at cursor position)
        #height = 0.6;
      };

      gitsigns.previewConfig.border = nvim_open_win;

      lspsaga = {
        definition.height = 0.5; # lspsaga definition floating window
        definition.width = 0.6; # lspsaga definition floating window
        hover.maxHeight = 0.8;
        hover.maxWidth = 0.9;
        rename.projectMaxHeight = 0.5;
        rename.projectMaxWidth = 0.5;
      };

      nvim-cmp.window = {
        completion.border = nvim_open_win;
        documentation.border = nvim_open_win;
      };

      #nvim-lightbulb.float.winOpts = {};

      nvim-ufo.preview.winConfig = {
        border = nvim_open_win;
        maxheight = 20; # Max height of preview window
        winblend = 12; # See :h winblend
        #  winhighlight = "Normal:Normal";  # See :h winhighlight
      };

      sniprun.borders = nvim_open_win;

      trouble = {
        padding = !compact; # Show extra newline at top of list
        height = 10; # List window lines when position=top|bottom
        width = 50; # List window cols  when position=left|right
      };

      which-key.window = {
        border = nvim_open_win;
        position = "bottom"; # bottom | top
        winBlend = 30; # 0=opaque, 100=transparent
        margin = if compact then { top = 0; bottom = 0; left = 0; right = 0; } else { top = 1; bottom = 1; left = 0; right = 0; };
        padding = if compact then { top = 0; bottom = 0; left = 1; right = 1; } else { top = 1; bottom = 1; left = 1; right = 1; };
      };

    };

}
