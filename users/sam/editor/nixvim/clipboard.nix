{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  programs.nixvim.clipboard = {
    register = "unnamedplus";
    # TODO: Make conditional if X11/Wayland enabled
    providers.wl-copy.enable = true;
    #providers.xclip.enable = true;
    #providers.xsel.enable = false;
  };

}
