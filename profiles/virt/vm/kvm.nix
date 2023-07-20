{ inputs, self
, config, lib, pkgs
, user ? "sam"
#, isCpuOld   ? false
#, isCpuIntel ? true
, ...
}:
let
  isCpuIntel = true;
  isCpuOld = false;
  isCpuIntelOld = isCpuIntel && isCpuOld;
in
{
  imports = [
  ];

  environment.systemPackages = [ pkgs.kvmtool ];

  # Share GPU / iGPU with guest VM
  virtualisation.kvmgt.enable = true;

  # Add primary user to kvm group so they can control KVM
  users.extraGroups.kvm = { name = "kvm"; members = [user]; };

  # Enable nested virtualization or guests to run KVM hypervisors inside them
  #  also, fix integrated graphics module on older Intel CPUs.
  boot.extraModprobeConfig = ''
    ${if isCpuIntel    then "options kvm_intel nested=1" else ""}
    ${if isCpuIntelOld then "options i915 enable_guc=2"  else ""}
  '';
}
