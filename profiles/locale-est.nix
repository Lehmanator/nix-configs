{ self, system, userPrimary, inputs, config, lib, pkgs, ... }: {
  imports = [
  ];

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.layout = "us";
}
