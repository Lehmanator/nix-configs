{ lib
, writeText
#, stdenv
, inputs
, system ? "x86_64-linux"
, ...
}:
let
  conditions = (host: cfg:
    cfg ? config &&
    cfg.config ? system &&
    cfg.config.system ? build &&
    cfg.config.system.build ? toplevel &&
    cfg.pkgs.stdenv.buildPlatform.system == system &&
    cfg.config.services.cachix-agent.enable
  );
in
writeText "cachix-deploy.json" builtins.toJSON {
  agents = lib.mapAttrs
    (host: cfg: cfg.config.system.build.toplevel)
    (lib.filterAttrs conditions inputs.self.nixosConfigurations)
  ;
}

