{ inputs, self
, config, lib, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
  ];

  virtualisation.oci-containers.backend = "podman";

  # Daemonless container engine for developing, managing, & running OCI Containers. Drop-in replacement for `docker` command.
  virtualisation.podman = {
    enable = true;
    enableNvidia = false;     # Enable use of NVidia GPUs from within podman containers.

    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [];        #["--all"];
    };

    # Settings for Podman's default network
    defaultNetwork.settings = {
      dns_enabled = true;
      dnsname.enable = true;
    };

    dockerCompat = true;           # Create alias mapping `docker` to `podman`
    dockerSocket.enable = true;    # Make Podman socket available in place of Docker's, so Docker tools can find Podman socket

    # Make Podman & Docker compatibility API available over the network w/ TLS client certificate authentication.
    #   This allows Docker clients to connect w/ the equivalents of the Docker CLI `-H` & `--tls*` family of options
    #   Cert Setup: https://docs.docker.com/engine/security/protect-access/
    #networkSocket = {
    #  enable = true;
    #  listenAddress = "0.0.0.0";  # Interface addr for receiving TLS connections
    #  openFirewall = true;        # Open port in firewall
    #  port = 2376;                # TCP port number for receiving TLS connections [0-65535]
    #  server = "ghostunnel";      # Choice of TLS proxy server. Options: "ghostunnel"
    #  tls.cacert = <PATH>;        # Path to CA certificate to use for client authentication
    #  tls.cert = <PATH>;          # Path to certificate describing the server
    #  tls.key = <PATH>;           # Path to private key for server cert. Warn: use string, else copied to nix store & readable by all processes.
    #};

    # Extra packages to be installed in the Podman wrapper
    #extraPackages = [
    #  pkgs.gvisor
    #];

  };

  # Enable default user in podman group so user can run podman commands without sudo
  #   User must be in `podman` group to connect to Podman socket.
  users.users."${user}".extraGroups = ["podman"];

}
