{ config, lib, pkgs, modulesPath, ... }:

# --- Visual Disk Unlock ---
# https://github.com/droidian/unl0kr
#
# TODO: Enable for mobile devices
# TODO: Deterrmine if system has encrypted partitions
#
# TODO: Does this work with keyboard & mouse?
# TODO: Only enable for mobile devices? touchscreens?
#
# TODO: Write configuration file.
# TODO: Create NixOS module for config options.
# TODO: Move config to profiles/mobile?
{
  boot.initrd.unl0kr = {
    enable = true;
  };
}
