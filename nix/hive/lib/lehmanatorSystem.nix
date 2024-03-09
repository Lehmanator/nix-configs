{ inputs, cell, }:
# ----
let
  inherit (inputs) nixpkgs self;
  lehmanatorSystem = nixpkgs.lib.makeOverridable ({ modules ? [ ]
                                                  , baseModules ? [ ]
                                                  , installer ? { }
                                                  , system ? "x86_64-linux"
                                                  , user ? "sam"
                                                  , specialArgs ? { inherit self inputs user; }
                                                  , ...
                                                  }:
    let
      selfSystem = inputs.nixos.lib.nixosSystem {
        specialArgs = { inherit inputs self user; }; # inherit (self) inputs;
        modules = baseModules ++ modules ++ [
          ({ pkgs, ... }: {
            system.build =
              let
                installerConfiguration = lehmanatorSystem {
                  inherit baseModules;
                  modules = [
                    {
                      nixpkgs.hostPlatform =
                        selfSystem.config.nixpkgs.hostPlatform;
                      nixpkgs.buildPlatform =
                        selfSystem.config.nixpkgs.buildPlatform;
                    }
                    (inputs.nixpkgs.lib.optionalAttrs
                      (selfSystem.config.system.build ? diskoScript)
                      {
                        system.build.installDiskoScript =
                          selfSystem.config.system.build.diskoScript;
                      })
                    {
                      system.build.installHostname =
                        selfSystem.config.networking.hostName;
                      system.build.installClosure =
                        selfSystem.config.system.build.toplevel;
                    }
                    #self.nixosModules.installer
                    ../../profiles/nixos/installer.nix
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
          })
        ];
      };
    in
    selfSystem);
in
lehmanatorSystem
