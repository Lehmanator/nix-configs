{ inputs
, config, lib, pkgs
, ...
}:
{
  # imports = [
  #   ./clipboard.nix
  #   ./keymaps.nix
  #   ./styles
  # ];

  # --- Nixvim Default Config ---
  programs.nixvim = {
    # defaultEditor = true;
    luaLoader.enable = true;
  };
}
