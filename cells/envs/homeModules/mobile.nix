{ self, inputs,
  config, lib, pkgs,
  ...
}: with lib;
let
  cfg = config.mobile-linux;
in
{

  imports = [
    #inputs.mobile.nixosModules
  ];

  options.mobile-linux = with types; {
    enable = mkEnableOption "desc";
  };

  config = mkIf cfg.enable {

    home.packages = [

    ];

    # --- Firefox ---
    # https://gitlab.com/postmarketOS/mobile-config-firefox/
    programs.firefox.profiles.default.settings."browser.bookmarks.showMobileBookmarks" = true;

  };

}
