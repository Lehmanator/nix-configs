{ inputs, cell, }@commonArgs:
#builtins.trace
#  (builtins.concatStringsSep "\n" [
#    "hive/pops/pkgs.nix:"
#    "system = ${inputs.nixpkgs.system}"
#    "  args = ${builtins.concatStringsSep "," (builtins.attrNames commonArgs)}"
#    "inputs = ${builtins.concatStringsSep "," (builtins.attrNames inputs)}"
#    #"cellName=${cellName}"
#    ""
#  ])
  #builtins.trace ([ "pops/pkgs.nix" ] ++ (builtins.attrNames inputs.nixpkgs))
  # TODO: Lenient config (e.g. allowBroken, allowUnfree, etc.)
  # TODO: Strict config (e.g. allowBroken, allowUnfree, etc.)
  #
  # TODO: Make all transposed inputs non-transposed
  # TODO: Add all system / environment related inputs manually.
  # TODO: Use nixos-* only in //hive/pkgs
  # TODO: Add branches: master, staging, staging-next, gnome
  # TODO: Collect all overlays from inputs
  inputs.omnibus.pops.load
{
  src = ../pkgs;
  inputs = {
    inherit cell;
    inputs = builtins.removeAttrs inputs [ "self" ];
  };
  #let
  #  # --- Transposed Inputs ----------------------------------------------------
  #  # Never have prime `'` appended (matching default std behavior)
  #  #
  #  # TODO: Transpose `inputs.omnibus.flake.inputs`
  #  # TODO: Rename transposed to remove `inputs.`, add prime ', and merge with this parent attrset.
  #  # TODO: Remove manual prime pkgs below
  #  #
  #  # e.g. mapAttrs:  inputs.<name> -> <name>`
  #  #
  #  # Formats:
  #  # - inputs'.<name>
  #  # - <name>'
  #  # --------------------------------------------------------------------------
  #  transposed = inputs // {
  #    # This flake
  #    #inherit self; # TODO: Transpose
  #    unstable = inputs.nixos-unstable;
  #    stable = inputs.nixos-stable;
  #    nixos = inputs.nixos-unstable;
  #  };
  #
  #  # --- Regular Inputs (non-transposed) --------------------------------------
  #  # Always have prime `'` appended
  #  #
  #  # i.e. Default cell arg `inputs` in std
  #  #
  #  # - inputs.<name>
  #  # - <name>
  #  # --------------------------------------------------------------------------
  #  # TODO: mapAttrs: inputs'.<name> -> <name>'
  #  inputs' =
  #    let omni = inputs.omnibus.flake.inputs;
  #    in omni // {
  #      # This flake
  #      inherit (inputs) self;
  #      unstable = omni.nixos;
  #      stable = omni.nixos-23_11;
  #      nixos-unstable = omni.nixos;
  #      nixos-stable = omni.nixos-23_11;
  #    };
  #  #commonArgs // {
  #in
  #{
  #  # Pass cell targets to cellBlock
  #  inherit cell;
  #
  #  # Transposed inputs + overrides
  #  inputs = transposed // { inherit (inputs) nixpkgs; };
  #
  #  # Non-transposed inputs
  #  inherit inputs';
  #
  #  # Add nixpkgs (non-transposed) as top-level cell arg.
  #  #inherit (inputs.omnibus.flake.inputs) nixpkgs;
  #};
}
