{ self, inputs,
  config, lib, pkgs,
  ...
}: with lib;
let
  cfg = config.firefox;
in
{

  imports = [
    inputs.nur.hmModules.nur
    #./addons
  ];

  options = with types; rec {
    firefox = {
      enable = mkEnableOption "Whether to enable Librewolf browser";
    };
    librewolf = firefox // {
      description = "Whether to enable Librewolf browser";
    };
    # TODO:Arkenfox, FF Nightly
    # TODO: https://github.com/Frewacom/pywalfox
    # TODO: https://github.com/Frewacom/pywalfox-native
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.nur.overlay.nur ];

    home.packages = [
      pkgs.chrome-token-signing
      pkgs.ff2mpv
      pkgs.fx_cast_bridge
      pkgs.vscode-extensions.firefox-devtools.vscode-firefox-debug

      pkgs.nur.repos.rycee.mozilla-addons-to-nix

    ]  ++ (with pkgs.nur.repos.rycee.firefox-addons; [
    ]) ++ (mkIf config.librewolf.enable [
      pkgs.librewolf
    ]);

    programs.firefox = {
      enable = true;
      package = pkgs.firefox.override {
        cfg = {
          enableGnomeExtensions = config.xserver.desktopManager.gnome.enable;
          enableTridactylNative = true;  # TODO: Module: ../keybinds/vim
        };
      };
    };
    programs.browserpass.browsers = [ "firefox" ];
  };

}
