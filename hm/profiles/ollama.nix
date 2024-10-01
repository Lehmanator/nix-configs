{ config, pkgs, lib, ... }: {
  home = {
    sessionVariables.OLLAMA_HOST = "45.42.244.197:11434";
    packages = [pkgs.ollama];
  };
  services.flatpak.packages = [
  ] ++ lib.mkIf config.programs.gnome-shell.enable "com.jeffser.Alpaca"
  ;
}
