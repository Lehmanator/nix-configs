{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [ inputs.ssbm-nix.nixosModule ];

  ssbm = {
    overlay.enable = true;
    cache.enable = true;
    gcc = {
      oc-kmod.enable = true;
      rules = {
        enable = true;
        #rules = ''
        #'';
      };
    };
    keyb0xx = {
      enable = false;
      #config = ''
      #'';
    };
  };
}
