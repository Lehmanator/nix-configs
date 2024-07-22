{ inputs, self, hostsDir, user ? "sam", ... }:
let
  lehmanatorSystem = inputs.nixos.lib.makeOverridable ({
    modules ? [],
    baseModules ? [],
    installer ? {},
    system ? "x86_64-linux",
    specialArgs ? {},
  }@overrideArgs: let
    inherit (inputs.nixos.lib) optionalAttrs nixosSystem;
    selfSystem = nixosSystem {
      inherit (overrideArgs) specialArgs;
      modules = baseModules ++ modules ++ [
        ({pkgs, ...}: {
          system.build = let
            installerConfiguration = lehmanatorSystem {
              inherit baseModules;
              modules = [
                { nixpkgs.hostPlatform = selfSystem.config.nixpkgs.hostPlatform;
                  nixpkgs.buildPlatform = selfSystem.config.nixpkgs.buildPlatform;
                }
                (optionalAttrs (selfSystem.config.system.build ? diskoScript) {
                  system.build.installDiskoScript = selfSystem.config.system.build.diskoScript;
                })
                { system.build.installHostname = selfSystem.config.networking.hostName;
                  system.build.installClosure = selfSystem.config.system.build.toplevel;
                }
                ../../nixos/profiles/installer.nix   #self.nixosModules.installer
                installer
              ];
            };
          in {
            installerSystem = installerConfiguration;
            installer = let
              isoName = installerConfiguration.config.isoImage.isoName;
              isoPath = "${installerConfiguration.config.system.build.isoImage}/iso/${isoName}";
            in pkgs.runCommandLocal isoName {inherit isoPath;} ''ln -s "$isoPath" $out'';
          };
        })
      ];
    };
  in selfSystem);
in lehmanatorSystem
