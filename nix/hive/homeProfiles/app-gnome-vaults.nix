{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [
  ];

  # Currently Vaults app isn't packaged for NixOS. Must install via flatpak
  # https://github.com/mpobaschnig/Vaults
  # https://flathub.org/apps/details/io.github.mpobaschnig.Vaults
  # - [ ] TODO: Package for NixOS
  # - [ ] TODO: Persist storage encrypted data directory with Impermanence

  home.packages = [
    # --- Client(s) ---
    # --- Backends ----
    pkgs.cryfs
    pkgs.gocryptfs
  ];

}
