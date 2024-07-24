{ config, lib, pkgs, ... }: {
  # home.packages = [ pkgs.gnome-calculator ]; # unstable
  home.packages = [ pkgs.gnome.gnome-calculator ];
  dconf.settings."org/gnome/calculator" = {
    #button-mode = "programming";
    show-thousands = true;
    base = 10;
    #word-size = 64;
    #window-position = lib.hm.gvariant.mkTuple [100 100];
  };
}
