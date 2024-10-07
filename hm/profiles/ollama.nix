{ config, pkgs, lib, ... }:
let
  inherit (lib) optional;
  prefers-flatpak = true;
in
{
  home = {
    sessionVariables.OLLAMA_HOST = "45.42.244.197:11434";
    packages = [
      pkgs.ollama
      pkgs.oterm
      # pkgs.aichat
    ] 
    ++ optional (! prefers-flatpak && config.programs.gnome-shell.enable) pkgs.alpaca
    ++ optional (! prefers-flatpak && config.programs.neovim.enable     ) pkgs.vimPlugins.ollama-nvim
    ;
  };
  services.flatpak.packages = [
  ] ++ (lib.optional config.programs.gnome-shell.enable "com.jeffser.Alpaca")
  ;
  programs.nushell.environmentVariables.OLLAMA_HOST = config.home.sessionVariables.OLLAMA_HOST;

  # TODO: Configure oterm
  # xdg.configFile."oterm/config.json".text = pkgs.writeText "config.json" (builtins.toJSON {
  # });

  # TODO: Configure AIChat
  # xdg.configFile."aichat/config.yaml".text = pkgs.writeText "config.yaml" (builtins.toJSON {
  #   stream = true;
  #   save = true;
  #   wrap = "auto";
  #   wrap_code = true;
  #   editor = config.home.sessionVariables.EDITOR;
  #   keybindings = "vi";
  #   save_session = true;
  #   highlight = true;
  #   clients = [
  #     { type="openai-compatible"; name="ollama"; api_base = "http://${config.home.sessionVariables.OLLAMA_HOST}"; }
  #   ];
  # });

  # TODO: Configure Alpaca
  # programs.dconf.settings."com/jeffser/Alpaca".text = ''
  # '';
}
