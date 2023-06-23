{ self, inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  programs.nixvim.plugins.floaterm = {
    enable = lib.mkDefault true;
    autoclose = 1;
    autohide = 1;
    autoinsert = true;
    borderchars = "─│─│┌┐┘└";
    giteditor = true;
    height = 0.6;
    #keymaps = { first=""; hide=""; kill=""; last=""; new=""; next=""; prev=""; show=""; toggle=""; };
    opener = "split"; # edit | split | vsplit | tabe | drop
    position = "auto"; # wintype=split: leftabove | aboveleft | rightbelow | belowright | topleft | botright
    # wintype=float: top | bottom | left | right | topleft | topright | bottomleft | bottomright | center | auto (at cursor position)
    rootmarkers = [ ".project" ".git" ".hg" ".svn" ".root" "flake.nix" ".github" ];
    wintype = "float";
  };

}
