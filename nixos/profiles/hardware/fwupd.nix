{ inputs
, config
, lib
, pkgs
, ...
}:
{
  services.fwupd = {
    enable = true;
    extraRemotes = [ "lvfs-testing" ];

    # Might be necessary once to make the update succeed
    # uefiCapsuleSettings.DisableCapsuleUpdateOnDisk = true;
  };
}
