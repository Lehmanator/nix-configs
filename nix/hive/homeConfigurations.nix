{
  inputs,
  cell,
  ...
} @ commonArgs:
#---------------------------------------------------------------
#cell.pops.homeConfigurations.exports.default or {}
#
#---------------------------------------------------------------
#inputs.haumea.lib.load { }
#
#---------------------------------------------------------------
# Note: mkHome wraps homeConfigurations, and:
# - Imports the configuration imports
# - Sets some standard hm options.
# - Configures a NixOS user for owner of the homeConfiguration
#
# Note: We want to create homeManagerConfigurations. mkHome would just use the attr `modules` passed to `lib.homeManagerConfiguration`
#{
#  sam = inputs.omnibus.src.mkHome inputs.home-manager.nixosModules.home-manager {
#    sam = {
#      uid = 1000;
#      description = "Sam Lehman";
#      isNormalUser = true;
#      extraGroups = ["wheel"];
#    };
#  } "zsh" (cell.homeSuites ++ cell.userProfiles.sam.default);
#}
#---------------------------------------------------------------
{
  sam = inputs.home-manager.lib.homeManagerConfiguration {
    #pkgs = inputs.nixpkgs.packages.x86_64-linux; # .legacyPackages;
    pkgs = inputs.nixpkgs; # .legacyPackages.${inputs.nixpkgs.system};
    modules = inputs.nixpkgs.lib.flatten [
      cell.homeSuites.developer-default
      cell.userProfiles.sam.default
      inputs.declarative-flatpak.homeManagerModules.declarative-flatpak
      inputs.sops-nix.homeManagerModules.sops
      ({user, ...}: {
        home = {
          username = "sam";
          homeDirectory = "/home/sam";
        };
        sops.defaultSopsFile = ./userProfiles/${user}/secrets/default.yaml;
      })
    ];
    extraSpecialArgs = {
      inherit inputs cell;
      user = "sam";
      osConfig = {
        #networking.hostName = "test";
        #security.sudo.enable = true;
        #programs = {
        #  vim.enable = false;
        #  neovim.enable = true;
        #  fzf.enable = true;
        #  ccache = {
        #    enable = true;
        #    cacheDir = "/var/lib/ccache";
        #  };
        #};
      };
    };
  };
}
