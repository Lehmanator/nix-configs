{
  #inputs, # cell,
  writeText, # open-vsx,
  lib,
  system,
  ...
} @ commonArgs: let
  argn = "${system} " + builtins.toString (builtins.attrNames commonArgs);
in
  lib.traceIf true argn (
    writeText "hive-packages-commonArgs" argn
    #(builtins.toString commonArgs)
  )
