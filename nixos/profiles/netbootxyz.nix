{ config, lib, ... }:
{
  # TODO: Enable networking, disks in initrd / UEFI?

  boot.loader = {

    systemd-boot.netbootxyz = {
      enable = lib.mkDefault true;
      entryFilename = lib.mkDefault "zz-netbootxyz";
    };

    # iPXE Commands: https://ipxe.org/cmd
    # iPXE Config Options: https://ipxe.org/cfg
    # Image URLs:
    # https://boot.netboot.xyz #            # Stable images
    # https://staging.boot.netboot.xyz/rc/  # Release candidate images
    grub.ipxe = let
      tld = with lib.strings; concatStringsSep "." (lib.lists.reverseList (splitString "." config.networking.domain));
      ipxe-config = ''
        #!ipxe
        set initiator-iqn iqn.2023-12.${tld}:${config.networking.hostName}
        set domain ${config.networking.domain}
        set net0/gateway ${config.networking.defaultGateway.address}
      '';
    in {
      # Demo iPXE image
      ipxe-demo = ''
        #!ipxe
        dhcp
        chain http://boot.ipxe.org/demo/boot.php
      '';
      # EFI iPXE image
      ipxe = ''
        #!ipxe
        dhcp
        chain --autofree http://boot.netboot.xyz/ipxe/netboot.xyz.efi
      '';
      # NICs w/ embedded iPXE support
      ipxe-embedded = ''
        #!ipxe
        dhcp
        chain --autofree https://boot.netboot.xyz
      '';
      # iPXE w/ manual DNS instead of DHCP
      # TODO: Use system config to match these to home network.
      ipxe-manual-dns = ''
        #!ipxe
        set net0/ip 192.168.1.2
        set net0/netmask 255.255.255.0
        set net0/gateway 192.168.1.1
        set dns 9.9.9.9
        chain --autofree https://boot.netboot.xyz
      '';
      # Interactive UI to configure iPXE
      ipxe-config = ''
        #!ipxe
        dhcp
        config
      '';
      # Runs a memory test & captures screenshot on failure
      ipxe-memtest-auto-screenshot = ''
        #!ipxe
        chain -a http://boot.ipxe.org/memtest.0 onepass onefail && goto ok || goto bad
        :bad
        params
        param screenshot \$\{vram}
        chain -a http://my.server.address/memtest_fail.php##params
        :ok
      '';
    };
  };
}
