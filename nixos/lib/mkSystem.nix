# https://github.com/lilyinstarlight/foosteros/flake.nix#L93
{
  inputs,
  self,
  ...
}: {
  mkSystem = let
    mkSystem =
      inputs.nixpkgs.lib.makeOverridable
      ({
        modules ? [],
        baseModules ? [],
        installer ? null,
      }: let
        selfSystem = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit self;
            inherit (self) inputs;
          };
          modules =
            baseModules # ++ [self.nixosModules.config]
            ++ modules
            ++ inputs.nixpkgs.lib.optionals (installer != null) [
              ({pkgs, ...}: {
                system.build = let
                  installerConfig = mkSystem {
                    inherit baseModules;
                    modules = [
                      {
                        nixpkgs.hostPlatform =
                          selfSystem.config.nixpkgs.hostPlatform;
                        nixpkgs.buildPlatform =
                          selfSystem.config.nixpkgs.buildPlatform;
                      }
                      (inputs.nixpkgs.lib.optionalAttrs
                        (selfSystem.config.system.build ? diskoScript) {
                          system.build.installDiskoScript =
                            selfSystem.config.system.build.diskoScript;
                        })
                      {
                        system.build.installHostname =
                          selfSystem.config.networking.hostName;
                        system.build.installClosure =
                          selfSystem.config.system.build.toplevel;
                      }
                      (import
                        ../profiles/installer.nix) # self.nixosModules.installer
                      installer
                    ];
                  };
                in {
                  installerSystem = installerConfig;
                  installer = let
                    isoName = installerConfig.config.isoImage.isoName;
                    isoPath = "${installerConfig.config.system.build.isoImage}/iso/${isoName}";
                  in
                    pkgs.runCommandLocal isoName {inherit isoPath;}
                    ''ln -s "$isoPath" $out'';
                };
              })
            ];
        };
      in
        selfSystem);
  in
    mkSystem;
}
