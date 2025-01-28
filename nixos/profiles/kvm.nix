{ config, lib, pkgs, user, ... }:
let
  isCpuIntel = true;
  isCpuOld = false;
  isCpuIntelOld = isCpuIntel && isCpuOld;
in
{
  # Enable nested virtualization or guests to run KVM hypervisors inside them
  #  also, fix integrated graphics module on older Intel CPUs.
  # TODO: Only on intel GPUs
  boot.extraModprobeConfig = lib.mkIf pkgs.stdenv.isx86_64 (
         if isCpuIntelOld then "options i915 enable_guc"
    else if isCpuIntel    then "options kvm_intel nested=1" else ""
  );
  
  # Share GPU / iGPU with guest VM
  # TODO: Only on intel GPUs
  virtualisation.kvmgt.enable = lib.mkIf pkgs.stdenv.isx86_64 isCpuIntel;

  # Add primary user to kvm group so they can control KVM
  users.extraGroups.kvm.members = [user];

  environment.systemPackages = [ pkgs.kvmtool ];
}
