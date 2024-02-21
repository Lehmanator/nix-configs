{
  config,
  lib,
  pkgs,
  ...
}: {
  clipboard = {
    register = "unnamedplus";

    # TODO: Make conditional if X11/Wayland enabled
    providers.wl-copy.enable = lib.mkDefault true;
    #providers.xclip.enable = true;
    #providers.xsel.enable = false;
  };
}
