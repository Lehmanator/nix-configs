{ inputs, cell, }:
let
  lehmanatorSystem = { self, user ? "sam", system ? "x86-64-linux", ... }:
    inputs.nixpkgs.lib.makeOverridable ({ modules ? [ ]
                                        , baseModules ? [ ]
                                        , installer ? { }
                                        , system ? "x86_64-linux"
                                        , specialArgs ? {
                                            inherit self inputs user;
                                            #inherit (self) inputs;
                                          }
                                        ,
                                        }:
      let
        selfSystem = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs self user; };
          modules =
            let
              installerModule = { pkgs, ... }: {
                system.build =
                  let
                    installerConfiguration = lehmanatorSystem {
                      inherit baseModules;
                      modules = [
                        {
                          nixpkgs = {
                            inherit (selfSystem.config.nixpkgs)
                              hostPlatform buildPlatform;
                          };
                        }
                        (inputs.nixpkgs.lib.optionalAttrs
                          (selfSystem.config.system.build ? diskoScript)
                          {
                            system.build.installDiskoScript =
                              selfSystem.config.system.build.diskoScript;
                          })
                        {
                          system.build = {
                            installHostname = selfSystem.config.networking.hostName;
                            installClosure =
                              selfSystem.config.system.build.toplevel;
                          } // {
                            installDiskoScript = inputs.nixpkgs.lib.optionalAttrs
                              (selfSystem.config.system.build ? diskoScript)
                              selfSystem.config.system.build.diskoScript;
                          };
                        }
                        #../../profiles/nixos/installer.nix
                        inputs.self.nixosProfiles.installer
                        installer
                      ];
                    };
                  in
                  {
                    installerSystem = installerConfiguration;
                    installer =
                      let
                        isoName = installerConfiguration.config.isoImage.isoName;
                        isoPath =
                          "${installerConfiguration.config.system.build.isoImage}/iso/${isoName}";
                      in
                      pkgs.runCommandLocal isoName { inherit isoPath; }
                        ''ln -s "$isoPath" $out'';
                  };
              };
            in
            baseModules ++ modules ++ installerModule;
        };
      in
      selfSystem);
in
lehmanatorSystem
