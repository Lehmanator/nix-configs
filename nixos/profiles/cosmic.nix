{ inputs, config, lib, pkgs, ... }:
{
  # --- COSMIC Desktop -----------------------------------------------
  #   Repo: https://github.com/lilyinstarlight/nixos-cosmic
  #   Wiki: https://wiki.nixos.org/wiki/COSMIC
  # Matrix: https://matrix.to/#/#cosmic:nixos.org
  #
  # { inputs = { cosmic.url = "github:lilyinstarlight/nixos-cosmic"; };
  #   outputs = { self, nixpkgs, cosmic, ...}: {
  #     nixosConfigurations.cosmic-host = nixpkgs.lib.nixosSystem {
  #       modules = [
  #         cosmic.nixosModules.default
  #         { nix.settings = { substituters=["https://cosmic.cachix.org/"]; trusted-public-keys=["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="]; }; }
  #       ];
  #     };
  #   };
  # }
  #
  # App Query: https://search.nixos.org/packages?query=cosmic&from=0&size=1000&sort=relevance&channel=unstable
  #
  imports = [
    inputs.cosmic.nixosModules.default
    (inputs.self + /nixos/profiles/gtk.nix)
    (inputs.self + /nixos/profiles/flatpak.nix)
    (inputs.self + /nixos/profiles/pipewire.nix)
    (inputs.self + /nixos/profiles/wayland.nix)
  ];

  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  nix.settings = {
    substituters = [ "https://cosmic.cachix.org/" ];
    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };

  # The zwlr_data_control_manager_v1 protocol needs to be available. 
  # Enable it in cosmic-comp via the following configuration:
  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
}
