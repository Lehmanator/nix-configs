{ config, lib, pkgs, user, ... }: {
  #
  # https://nixos.wiki/wiki/TPM
  #
  security.tpm2 = {
    enable = true;
    #applyUdevRules = true;
    #abrmd.enable = true;
    #abrmd.package = pkgs.tpm2-abrmd;
    # pkcs11.enable = lib.mkDefault false; # Temporarily disable to fix build
    pkcs11.enable = true;
    #pkcs11.package = pkgs.tpm2-pkcs11;
    tctiEnvironment = {
     enable = true;
     # interface = "device";  # device | tabrmd
     # deviceConf = "/dev/tpmrm0";
     # tabrmdConf = "bus_name=com.intel.tss2.Tabrmd";
    };
    #tssGroup = "tss";
    #tssUser = if config.security.tpm2.abrmd.enable then "tss" else "root";
  };

  #services.tcsd = {
  #  enable = true;
  #  firmwarePCRs = "0,1,2,3,4,5,6,7";
  #  kernelPCRs = "8,9,10,11,12";
  #  conformanceCred = "${config.services.tcsd.stateDir}/conformance.cert";
  #  endorsementCred = "${config.services.tcsd.stateDir}/endorsement.cert";
  #  platformCred = "${config.services.tcsd.stateDir}/platform.cert";
  #};

  # users.extraGroups.${config.security.tpm2.tssGroup}.members = [ user ];
  users.users.${user}.extraGroups = ["tss"];

  boot.initrd.systemd.enableTpm2 = lib.mkDefault config.security.tpm2.enable;
  # virtualisation.tpm.enable = lib.mkDefault config.security.tpm2.enable;

  environment.systemPackages = [
    pkgs.tpm2-tss
    # (pkgs.writeShellScript "tpm-setup" ''
    #   systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/nvme0n1p2
    # '')
  ];
}
