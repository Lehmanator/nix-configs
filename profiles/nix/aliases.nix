{ self, inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];


  environment.shellAliases = let
    flakeDir = "~/.config/nixos";
  in rec {
    cfgd     = "cd ${flakeDir}";
    # TODO: Conditional if pkgs.manix installed
    # TODO: Reference binary via package
    ndoc = "manix \"\" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview=\"manix '{}'\" | xargs manix";
    n        = "nix";
    nb       = "${n} build";
    build    = "${n} build";
    develop  = "${n} develop";
    registry = "${n} registry";
    neval    = "${n} eval";
    flake    = "${n} flake";    nf = "${n} flake";
    profile  = "${n} profile";
    repl     = "${n} repl";
    run      = "${n} run";
    store    = "${n} store";
  };
}
