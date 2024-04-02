{
  inputs,
  cell,
  ...
} @ commonArgs: {...}:
builtins.baseNameOf ./.
#(builtins.removeAttrs inputs.self.units ["jupenv"]).nixos
#
#inputs.nixpkgs
#
#builtins.elemAt
#(builtins.attrValues (builtins.removeAttrs inputs.self.units ["jupenv"]))
#3
#builtins.attrNames
#builtins.attrNames inputs.self.units.std
#inputs.nixpkgs.lib.debug.traceVal commonArgs
##builtins.toFile "test-cell-args.json"
#{...}: (builtins.toJSON
#  #{}
#  #(builtins.removeAttrs
#  (builtins.mapAttrs (n: v:
#    if builtins.isFunction v
#    then builtins.toString v
#    else if builtins.isAttrs v
#    then builtins.toString v
#    else v)
#  commonArgs))
