{ lib , pkgs , ... }: {
  home.packages = [ pkgs.dino ];

  #imports = [inputs.declarative-flatpak.homeManagerModules.default];
  #services.flatpak.packages = [
  #  "flathub:app/im.dino.Dino//stable"
  #  "flathub-beta:app/im.dino.Dino//beta"
  #];

  # TODO: Protocol string handler for XMPP chats

}
