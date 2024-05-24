{ inputs, cell, self, }@args:
let
  # t
  #builtins.trace
  #  (
  #    #builtins.attrNames
  #    #inputs.self.colmenaHive.nodes
  #    #if builtins.hasAttr "system" self then self.system else self # "butthole"
  #    #self.system
  #    "minimal-meta-bhole"
  #  )
in
{
  system = "x86_64-linux";
  specialArgs = args // { user = "sam"; };
  # Is this `nixpkgs.config`?
  colmena = { nixpkgs = { }; };
  colmenaConfiguration = {
    inherit (self.nixosConfiguration) bee imports;
    #specialArgs = args // { user = "sam"; };
    deployment = {
      allowLocalDeployment = true;
      targetHost = "127.0.0.1";
      tags = [ "minimal" "test" ];
    };
  };
  homeConfiguration = {
    inherit (self.nixosConfiguration) bee;
    imports = [ ];
    home = rec {
      inherit (self.nixosConfiguration.system) stateVersion;
      username = self.specialArgs.user;
      homeDirectory = "/home/${username}";
    };
  };
  nixosConfiguration = rec {
    system.stateVersion = "24.05";
    _module = {
      args = self.specialArgs;
      #specialArgs = self.specialArgs;
    };
    bee = {
      inherit (self) system;
      #inherit (inputs) darwin wsl;
      home = inputs.home-manager; # TODO: cell.pkgs.nixos-hm
      pkgs = inputs.cells.repo.pkgs.vscode;
      #pkgs = cell.pkgs.unstable-with-overlays;
    };
    imports = [
      #{
      #}
      inputs.disko.nixosModules.default
      inputs.sops-nix.nixosModules.sops
      inputs.srvos.nixosModules.desktop
      inputs.srvos.nixosModules.mixins-nix-experimental
      inputs.srvos.nixosModules.mixins-systemd-boot
      inputs.srvos.nixosModules.mixins-terminfo
      inputs.srvos.nixosModules.mixins-tracing
      inputs.srvos.nixosModules.mixins-trusted-nix-caches
      #inputs.srvos.nixosModules.roles-nix-remote-builder # github-actions-runner prometheus
      cell.nixosModules.debug
      #cell.nixosProfiles.home-manager
      cell.nixosProfiles.homed
      cell.nixosProfiles.locale-est
      cell.nixosProfiles.networkmanager
      cell.nixosProfiles.pipewire
      cell.nixosProfiles.sshd
      cell.nixosProfiles.sudo-rs
      #cell.nixosProfiles.test
      cell.nixosProfiles.user-primary

      cell.diskoConfigurations.wyse
    ];
    xdg.portal = { enable = true; extraPortals=[bee.pkgs.xdg-desktop-portal-gtk]; };
    #networking.hostName = "minimal";
    #home-manager.users.sam = ./users/sam;

  };
}
