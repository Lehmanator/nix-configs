{ inputs, self, config, lib, pkgs, border ? "rounded", ... }:
{
  imports = [
  ];

  programs.nixvim.plugins = {

    floaterm = {         # Floating terminal
      opener = "split";  # Options: edit | split | vsplit | tabe | drop
      position = "auto"; # wintype=split: leftabove | aboveleft | rightbelow | belowright | topleft | botright
      wintype = "float"; # wintype=float: top | bottom | left | right | topleft | topright | bottomleft | bottomright | center | auto (at cursor position)
      #height = 0.6;
    };

    lspsaga.definition = {  # lspsaga definition floating window
      height = 0.5;
      width = 0.6;
    };
    lspsaga.hover.maxHeight = 0.8;
    lspsaga.hover.maxWidth = 0.9;
    lspsaga.rename.projectMaxHeight = 0.5;
    lspsaga.rename.projectMaxWidth = 0.5;


  };

}
