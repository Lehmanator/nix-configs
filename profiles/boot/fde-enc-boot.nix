{ inputs
, self
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  };
  boot.initrd = {
    kernelModules = [ "usb_storage" ];
    luks.devices = {
      root = {
        device = "/dev/disk/by-uuid/d1f565b9-ff81-430d-a963-01556f876f68";
        preLVM = true;
      };
      #luksroot = {
      #  device = "/dev/disk/by-id/nvme-WD_BLACK_SN770_2TB_22382X803513-part2";
      #  device = "/dev/disk/by-id/nvme-WD_BLACK_SN770_2TB_22382X803513_1-part2";
      #  device = "/dev/disk/by-partuuid/cd78cb18-77b4-4e9f-ae19-f5a66735b2c1";
      #  device = "/dev/disk/by-partuuid/e67ce0ce-ad9e-488d-af6e-fb0bfc3e8059";
      #  device = "/dev/disk/by-path/pci-0000:01:00.0-nvme-1-part1";
      #  device = "/dev/disk/by-path/pci-0000:01:00.0-nvme-1-part2";
      #  device = "/dev/disk/by-uuid/6674-832F";
      #  device = "/dev/disk/by-uuid/d1f565b9-ff81-430d-a963-01556f876f68";
      #  allowDiscards = true;
      #  keyFileSize = 4096;
      #  keyFile = "/dev/sdb"; # For keyfile written to start of USB disk
      #};
    };
  };
}
