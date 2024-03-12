{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  # TODO: Move distrobox / chroot stuff to a different file (./virt/chroot.nix)
  # TODO: Add Atoms when nixpkg available. https://github.com/AtomsDevs/Atoms
  # TODO: Set flatpak permissions for Atoms: talk to `org.freedesktop.Flatpak`
  home.packages = [
    pkgs.distrobox
  ];

}
