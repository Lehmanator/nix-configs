{
  config,
  lib,
  pkgs,
  ...
}: {
  plugins.which-key = {
    enable = true;
    icons.separator = lib.mkDefault " ➜  ";
    icons.group = lib.mkDefault "󰙅 ";
    layout.align = lib.mkDefault "left";
    layout.spacing = lib.mkDefault 3;
    window.border = lib.mkDefault "rounded";
    window.winblend = lib.mkDefault 40;
  };
}
