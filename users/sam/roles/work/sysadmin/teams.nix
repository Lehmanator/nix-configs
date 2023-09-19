{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [ pkgs.teams-for-linux ];

  xdg.configFile.teams-config = {
    target = "${config.xdg.configHome}/teams-for-linux/config.json";
    text = builtins.toJSON {
      #chromeUserAgent = "";
      customCSSName = "compactDark"; # compactLight | compactDark | condensedLight | condensedDark | tweaks
      customCSSLocation = config.xdg.configFile.teams-config.target; # compactLight | compactDark | condensedLight | condensedDark | tweaks
      appIdleTimeout = "3600"; # 1 hour
      appActiveCheckInterval = 30; # 30 seconds
    };

  xdg.configFile.teams-styles = {
      target = "${config.xdg.configHome}/teams-for-linux/customStyles.css";
      text = ''
      '';
    };
  };

}
