{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  programs.nixvim.plugins = {
    dap.extensions.dap-go.enable = true;
  };
}
