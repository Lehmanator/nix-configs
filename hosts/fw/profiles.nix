{ config, lib, pkgs, inputs, ... }:
let
  #
  inherit (inputs) self;
  inp = lib.debug.traceIf (inputs."self" == null) inputs;
  inp2 = lib.debug.traceIf (self.nixosProfiles == null) inputs.self;
  dbg = true;
in
{
  imports = [
    self.nixosProfiles.apparmor
    self.nixosProfiles.cachix-agent
    self.nixosProfiles.desktop
    self.nixosProfiles.display-base
    self.nixosProfiles.gnome
    self.nixosProfiles.hercules-ci
    self.nixosProfiles.locale-est.nix
    self.nixosProfiles.peripherals-apple
    self.nixosProfiles.peripherals-logitech
    self.nixosProfiles.tailscale-mullvad-exit-node
    self.nixosProfiles.tpm2
    #self.nixosProfiles.homed
    #self.nixosProfiles.sops
    #self.nixosProfiles.user-primary
    #self.nixosProfiles.peripherals-printers
    #self.nixosProfiles.peripherals-scanners
    #self.nixosProfiles.server-k3s-node-main
    #self.nixosProfiles.ssbm-nix
    ../../profiles/nixos
    ../../profiles/nixos/boot.nix
    ../../profiles/nixos/security.nix
    ../../profiles/nixos/virt.nix

    # --- Disabled ---
    #self.nixosProfiles.fprintd
    #../../profiles/common/editor
  ];
}
