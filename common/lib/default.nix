{lib}:
lib.makeExtensible (self:
let
  callLibs = file: import file { lib = self; };
in rec {
  # Define library functions here
  #id = x: x;

  # Or add libs from files containing functions that take {lib}
  #foo = callLibs ./foo.nix

  # In configs, they can be used under "lib.our";
})
