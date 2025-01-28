{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [inputs.disko.nixosModules.disko];

  disko = {
    enableConfig = lib.mkDefault true;
    checkScripts = true;
    memSize = lib.mkDefault 4096; # Pass size of memory to runInLinuxVM (in megabytes)
    rootMountPoint = lib.mkDefault "/mnt";

    #devices = {};

    #tests = {
    #  efi = config.boot.loader.systemd-boot.enable || config.boot.loader.grub.efiSupport;
    #  extraChecks = ''
    #    machine.succeed("test -e /var/secrets/my.secret")
    #  '';
    #  # Extra NixOS config for your test. Can be used to specify a diff luks key for tests.
    #  # A dummy key is in /tmp/secret.key
    #  extraConfig = { };
    #};
  };

  sops.secrets = {
    luks-password-system = {};
    luks-password-home = {};
    luks-password-data = {};
  };
}
