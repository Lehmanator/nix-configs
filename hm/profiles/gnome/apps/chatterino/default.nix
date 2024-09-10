{ inputs, config, lib, pkgs, ... }: {
  # TODO: Move to `../../../apps/chatterino`
  #imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
  #services.flatpak.packages = [{ appId="com.chatterino.chatterino"; origin="flathub"; }];
  home.packages = [ pkgs.chatterino2 ];
}
