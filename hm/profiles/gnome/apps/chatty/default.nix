{ inputs, config, lib, pkgs, ... }: {
  #imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
  #services.flatpak.packages = [{origin="flathub"; appId="sm.puri.Chatty";}];
  home.packages = [pkgs.chatty];
  # TODO: Create package + overlay with GTK4 patches
  # TODO: Protocol handler strings for: sms, xmpp, matrix?
}
