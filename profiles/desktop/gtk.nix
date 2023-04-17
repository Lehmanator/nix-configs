{ self, inputs, outputs,
  config, lib, pkgs,
  system,
  host, repo, user, network, machine,
  ...
}:
{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    adw-gtk3
  ];
  
  gtk.iconCache.enable = true;

  # GTK3 plugin to show popup to search compatible application's menus
  programs.plotinus.enable = lib.mkDefault true;
  programs.sway.wrapperFeatures.gtk = true;
  #services.xserver.displayManager.lightdm.greeters.gtk.enable = lib.mkDefault true;
}
