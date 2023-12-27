{ inputs
, config
, lib
, pkgs
, ...
}:
{
  home.packages = [
    pkgs.chatty
    #pkgs.chatty-gtk4  # TODO: Create package + overlay with GTK4 patches
  ];

  #imports = [inputs.declarative-flatpak.homeManagerModules.default];
  #services.flatpak.packages = [ "flathub:app/sm.puri.Chatty//stable" ];

  # TODO: Protocol handler strings for: sms, xmpp, matrix?
}
