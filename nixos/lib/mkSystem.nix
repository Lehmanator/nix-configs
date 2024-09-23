# https://github.com/lilyinstarlight/foosteros/flake.nix#L93
{ inputs, self, ... }: {
  mkSystem = let
    mkSystem = inputs.nixpkgs.lib.makeOverridable ({
      modules ? [],
      baseModules ? [],
      installer ? null,
      specialArgs ? {},
    }: let
      inherit (inputs.nixpkgs.lib) mkIf nixosSystem optional optionalAttrs;
      selfSystem = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs self; };
          modules = baseModules ++ modules ++ inputs.nixpkgs.lib.optionals (installer != null) [
              ({pkgs, ...}: {
                system.build = let
                  installerConfig = mkSystem {
                    inherit baseModules;
                    modules = [
                      { inherit (selfSystem.config) nixpkgs;
                        # nixpkgs.hostPlatform = selfSystem.config.nixpkgs.hostPlatform;
                        # nixpkgs.buildPlatform = selfSystem.config.nixpkgs.buildPlatform;
                        system.build = {
                          installHostname = selfSystem.config.networking.hostName;
                          installClosure  = selfSystem.config.system.build.toplevel;
                        } // optionalAttrs selfSystem.config.system.build ? "diskoScript" {
                          installDiskoScript = selfSystem.config.system.build.diskoScript;
                        };
                      }
                      (import ../profiles/installer.nix)  installer
                    ]
                     # ++ optional selfSystem.config.system.build ? "diskoScript"
                     # { system.build.installDiskoScript = selfSystem.config.system.build.diskoScript; }
                    ;
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
      in selfSystem);
  in mkSystem;
}
