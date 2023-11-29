{ inputs, config, lib, pkgs, user, ... }: {
  imports = [ ];
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = false;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  sound.enable = true;
  users.users.${user}.extraGroups = [ "audio" ];
}
