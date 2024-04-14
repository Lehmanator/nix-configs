{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  plugins = {dap.extensions.dap-go.enable = true;};
}
