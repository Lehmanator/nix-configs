{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [
    # TODO: Move to ./android/default.nix
    # TODO: Create  ./android/anbox.nix
    # TODO: Create  ./android/waydroid.nix
    #./anbox.nix
    #./waydroid.nix
  ];

  environment.systemPackages = [
    pkgs.genymotion                                # Fast and easy Android emulation
    pkgs.wl-clipboard                              # Needed to share wayland clipboard with waydroid
    #pkgs.nur.repos.ataraxiasjel.waydroid-script    # Script to add extras to waydroid
  ];

  # --- Waydroid -------------------------------------------
  virtualisation.waydroid.enable = true;
  virtualisation.lxd.enable = true;
}
