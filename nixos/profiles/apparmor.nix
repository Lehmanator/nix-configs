{ lib, pkgs, ... }:
{
  security.apparmor = {
    enable = lib.mkDefault true;

    # Enable caching of AppArmor policies in /var/cache/apparmor/.
    #   Beware that AppArmor policies almost always contain Nix store paths,
    #   and thus produce at each change of these paths a new cached version accumulating in the cache.
    # TODO: Create activationScripts.apparmor-cache-refresh
    #enableCache = false;

    # Enable killing of processes which have AppArmor profile enabled (in security.apparmor.policies) but are not confined (because AppArmor can only confine new processes. Sends SIGTERM signal. Due to limitation of AppArmor, only profiles w/ exact paths (and no name) can enable such kills.
    #killUnconfinedConfinables = false;

    #includes = {
    #};
    #packages = [
    #];
    #policies = {
    #  #<name> = {
    #  #  enable = true;
    #  #  enforce = true;
    #  #  profile = ''
    #  #  '';
    #  #};
    #};
  };

  services.dbus.apparmor = "enabled"; # enabled = enables mediation when supported in kernel | disabled = always disabled | required = fails when AppArmor not found in kernel

  #security.pam.services.<name>.enableAppArmor = false;   # Enable support for attaching AppArmor profiles at the user/group level.

  environment.systemPackages = [
    #pkgs.apparmor-pam
    pkgs.apparmor-bin-utils # Installed if AppArmor enabled
    pkgs.apparmor-kernel-patches
    pkgs.apparmor-parser
    pkgs.apparmor-profiles
    pkgs.apparmor-utils # Installed if AppArmor enabled
  ];
}
