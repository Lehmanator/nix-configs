{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  services.udisks2 = {
    enable = true;
    # See:
    # https://manpages.ubuntu.com/manpages/lunar/en/man8/udisks.8.html
    # https://manpages.ubuntu.com/manpages/lunar/en/man5/udisks2.conf.5.html
    settings = {
      "udisks2.conf" = {
        defaults.encryption = "luks2";
      };
      udisks2 = {
        modules = [ "*" ];
        modules_load_preference = "ondemand";
      };
    };
    mountOnMedia = false;  # Mount to /media instead of /run/user/${uid}
  };
  #programs.gnome-disks.enable = true;

  # Mount NTFS filesystems
  environment.systemPackages = [ pkgs.ntfs3g ];

  # Mount NTFS filesystems during boot process
  #boot.supportedFilesystems = ["ntfs"];
}

