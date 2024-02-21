{
  lib,
  pkgs,
  ...
}: {
  nix.settings = lib.mkIf pkgs.stdenv.isLinux {
    auto-allocate-uids = true;
    experimental-features = ["auto-allocate-uids"];
  };
}
