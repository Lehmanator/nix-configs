#{ self, inputs,
#  config, lib, pkgs,
{ pkgs,
  ...
}:
# TODO: import "./personal.nix"
# TODO: import "./personal.nix"
# TODO: import "./privacy.nix"
# TODO: import "./archlinux.nix"
# TODO: import "./dev.nix"
# TODO: import "./torrent.nix"
# TODO: import "./unprivate.nix"
(
  import ./nixos.nix { inherit pkgs; }
) //
{

  # --- Search Engines ---
  #programs.firefox.profiles.default.search.default = "DuckDuckGo";
  #programs.firefox.profiles.default.search.engines = {
  # TODO: Determine if each engine should have its own file, or use groups of engines in files.

  # TODO: Move Google, Bing to `./unprivate.nix`
  "Bing".metaData.hidden = true;
  "DuckDuckGo".metaData.alias = "@d";
  "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias

}
