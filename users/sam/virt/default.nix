{ inputs
, self
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    # TODO: Distinguish b/w emulation, virtualization, containerization, & foreign packaging formats?
    #./android.nix
    #./containers.nix
    #./containers/compose.nix
    #./containers/docker.nix
    #./containers/kubernetes.nix
    #./containers/helm.nix
    #./containers/podman.nix
    #./chroot
    #./chroot/distrobox.nix
    #./packages.nix
    #./windows
    #./windows/bottles.nix
    #./windows/lutris.nix
    #./windows/playonlinux.nix
    #./windows/wine.nix
    ./distrobox.nix
    ./vm.nix
  ];

  # TODO: Podman
  # TODO: DistroBox
  # TODO: Bottles
  # TODO: WINE
  # TODO: VMs
  # TODO: Remote desktop protocol & VNC

}
