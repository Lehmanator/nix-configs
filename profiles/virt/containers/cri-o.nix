{ inputs, self
, config, lib, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
  ];

  # Container Runtime Interface for OCI  (CRI-O)
  virtualisation.cri-o = {
    enable = true;  # Default: false
    #extraPackages = [
    #  #pkgs.gvisor
    #];
    #logLevel = "info";
    #pauseCommand = null;   #"/pause";                # Override the default pause command
    #pauseImage = null;     #"k8s.gcr.io/pause:3.2"   # Override the default pause image for pod sandboxes
    #runtime = null;        #"crun";                  # Override the default runtime
    settings = {           # TOML config for cri-o.  # See: https://github.com/cri-o/cri-o/blob/master/docs/crio.conf.5.md
    };
    storageDriver = "overlay";   # aufs | btrfs | devmapper | overlay | vfs | zfs    # Storage driver to be used

  };

}
