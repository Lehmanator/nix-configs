{ config, pkgs, lib, ... }: {
  home = {
    sessionVariables.OLLAMA_HOST = "45.42.244.197:11434";
    packages = [pkgs.ollama];
  };
  services.flatpak.packages = [
  ] ++ (lib.optional config.programs.gnome-shell.enable "com.jeffser.Alpaca")
  ;
  programs.nushell.environmentVariables.OLLAMA_HOST = config.home.sessionVariables.OLLAMA_HOST;
}
