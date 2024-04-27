{
  config,
  lib,
  pkgs,
  ...
}:
# https://github.com/unixorn/awesome-zsh-plugins
{
  # TODO: Import from .. instead?
  # TODO: Define with programs.zsh.plugins in every file?
  # TODO: or filter default.nix from attrNames?
  imports =
    map (n: "${./plugins}/${n}")
    (builtins.attrNames (builtins.readDir ./plugins));
}
