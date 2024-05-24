{ inputs, config, lib, pkgs, user, ... }: {
  hardware.pulseaudio.enable = lib.mkForce false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = lib.mkDefault true;
    alsa.support32Bit = lib.mkDefault true;
    pulse.enable = lib.mkDefault true;
  };
  sound.enable = true;
  users.users.${user}.extraGroups = [ "audio" ];
  environment.systemPackages = [
    pkgs.gst_all_1.gst-plugins-ugly
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-plugins-base
  ] ++ lib.optionals config.services.xserver.desktopManager.gnome.enable [
    pkgs.easyeffects
    pkgs.gnomeExtensions.easyeffects-preset-selector
  ];
}
