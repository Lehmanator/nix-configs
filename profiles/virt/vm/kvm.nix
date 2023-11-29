{ inputs
, config
, lib
, pkgs
, user
, ...
}:
let
  isCpuIntel = true;
  isCpuOld = false;
  isCpuIntelOld = isCpuIntel && isCpuOld;
in
{
  # Enable nested virtualization or guests to run KVM hypervisors inside them
  #  also, fix integrated graphics module on older Intel CPUs.
  boot.extraModprobeConfig = "${if isCpuIntelOld then "options i915 enable_guc" else if isCpuIntel then "options kvm_intel nested=1" else ""}";
  # Share GPU / iGPU with guest VM
  virtualisation.kvmgt.enable = true;
  # Add primary user to kvm group so they can control KVM
  users.extraGroups.kvm.members = [ user ];
  environment.systemPackages = [ pkgs.kvmtool ];
}
