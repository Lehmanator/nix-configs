{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  environment = {
    # TODO: Remove pkgs that are imported elsewhere
    shellAliases = let
      flakeDir = "~/.config/nixos";
    in rec {
      cfgd     = "cd ${flakeDir}";
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

    # --- Utils ----------------------------------------------
    systemPackages = [
      pkgs.cachix # CLI for cachix binary caches
      pkgs.deadnix # Find dead code in Nix configs
      pkgs.manix # Search documentation
      pkgs.nix-doc # Search docs & Generate tags + plugin
      pkgs.nix-plugins # Misc Nix plugins
      pkgs.nix-du # Show sizes of Nix store paths
      pkgs.nix-init # Generate packages from URLs
      pkgs.nix-output-monitor
      pkgs.nix-tree # Interactively view dep graphs of Nix derivations
      pkgs.nix-update # Update Nix packages
      #pkgs.nix-query-tree-viewer # GUI to view Nix store path deps
      pkgs.nurl # Automatically generate fetcher expressions from URLs
      #pkgs.nvfetcher # Update package commits & hashes
      pkgs.pre-commit # Git pre-commit hooks
      pkgs.vulnix # Nix(OS) vulnerability scanner
    ];
  };

}
