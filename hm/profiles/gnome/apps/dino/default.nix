{ inputs , config , lib , pkgs , ... }: {
  home.packages = [ pkgs.dino ];

  #imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
  #services.flatpak.packages = [
  #  { origin="flathub";      appId="im.dino.Dino"; }
  #  { origin="flathub-beta"; appId="im.dino.Dino"; }
  #];

  # TODO: Protocol string handler for XMPP chats
}
