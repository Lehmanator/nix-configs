{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    ../../pipewire.nix
  ];

  # Audio effects for Pipewire & apps
  environment.systemPackages = lib.mkIf config.services.pipewire.audio.enable [
    pkgs.easyeffects
    pkgs.gnomeExtensions.easyeffects-preset-selector  # environment.systemPackages = [pkgs.easyeffects];
  ];

}
