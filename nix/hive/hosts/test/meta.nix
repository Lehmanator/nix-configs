{ self, inputs, cell, ... }@args:
#builtins.trace ([ "TEST-META" ] ++ (builtins.attrNames args))
{
  myargs = args;
  system = "x86_64-linux";
  specialArgs = { user = "sam"; };
  colmena = {
    nixpkgs = { system = "x86_64-linux"; }; # Is this `nixpkgs.config`?
  };
  colmenaConfiguration = {
    inherit (self.nixosConfiguration) bee imports;
    deployment = {
      allowLocalDeployment = true;
      tags = [ "test" ];
      #buildOnTarget = false;
      #replaceUnknownProfiles = true;
      #keys = { };
      #privilegeEscalationCommand = [ "sudo" "-H" "--" ];
      #targetHost = "127.0.0.1";
      #targetPort = null;
      #targetUser = "root";
      #sshOptions = [ ];
    };
  };
  #homeConfiguration = {
  #  inherit (self.nixosConfiguration) bee; # imports;
  #  home = rec {
  #    inherit (self.nixosConfiguration.system) stateVersion;
  #    username = self.specialArgs.user;
  #    homeDirectory = "/home/${username}";
  #  };
  #  imports = with inputs; [
  #    nix-flatpak.homeManagerModules.nix-flatpak
  #  ];
  #};
  nixosConfiguration = {
    system.stateVersion = "24.05";
    bee = {
      #inherit (self) system;
      system = "x86_64-linux";
      #inherit (inputs.omnibus.flake.inputs) darwin;
      home = inputs.home-manager;
      pkgs = cell.pkgs.unstable-with-overlays;
      #pkgs = import inputs.nixpkgs {
      #  overlays = with inputs; [
      #    agenix.overlays.default
      #    arion.overlays.default
      #    audioNix.overlays.default
      #    devshell.overlays.default
      #    fenix.overlays.default
      #    flake_env.overlays.default
      #    microvm.overlay
      #    nil.overlays.coc-nil
      #    nil.overlays.nil
      #    nix-filter.overlays.default
      #    nuenv.overlays.nuenv
      #    nur.overlay
      #    ragenix.overlays.default
      #    snapshotter.overlays.default
      #    sops-nix.overlays.default
      #    typst.overlays.default
      #    inputs.nix-vscode-extensions.overlays.default
      #  ];
      #};
    };
    imports = with inputs; [
      {
        _module.args = self.specialArgs;
      }
      # --- omnibus ---
      #agenix.nixosModules.age
      arion.nixosModules.arion
      disko.nixosModules.default
      microvm.nixosModules.host
      ragenix.nixosModules.age
      #snapshotter.nixosModules.default #containerd k3s nix-snapshotter preload-containerd (all have -rootless versions)
      sops-nix.nixosModules.sops
      srvos.nixosModules.desktop
      #srvos.nixosModules.server
      #srvos.nixosModules.mixins-nginx
      srvos.nixosModules.mixins-nix-experimental
      srvos.nixosModules.mixins-systemd-boot
      #srvos.nixosModules.mixins-telegraf
      srvos.nixosModules.mixins-terminfo
      srvos.nixosModules.mixins-tracing
      srvos.nixosModules.mixins-trusted-nix-caches
      #srvos.nixosModules.roles-github-actions-runner
      srvos.nixosModules.roles-nix-remote-builder
      #srvos.nixosModules.roles-prometheus

      # --- flake.nix ---
      nix-flatpak.nixosModules.nix-flatpak
      # --- std ---
      cell.nixosModules.debug
      #inputs.cells.android.nixosModules.attestation-server
    ];
  };
}
