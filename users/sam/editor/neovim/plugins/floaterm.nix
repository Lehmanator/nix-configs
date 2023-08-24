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
    giteditor = true;
    height = 0.6;
    rootmarkers = [ ".project" ".git" ".hg" ".svn" ".root" "flake.nix" ".github" ];
  };

}
