{ self, system, userPrimary, inputs, config, lib, pkgs, ... }: {
  imports = [
  ];

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = false;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  sound.enable = true;

  users.users."sam".extraGroups = [ "audio" ];
}
