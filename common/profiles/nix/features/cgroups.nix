{
  lib,
  pkgs,
  ...
}: {
  nix.settings = lib.mkIf pkgs.stdenv.isLinux {
    use-cgroups = true;
    experimental-features = ["cgroups"];
  };
}
