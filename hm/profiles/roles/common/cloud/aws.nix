{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./default.nix
  ];

  programs.bash-my-aws.enable = true; # D: false
  services.awstats = {
    enable = true; # D:false
    dataDir = "/var/lib/awstats"; # D:/var/lib/awstats
    updateAt = "hourly"; # D:null

    # TODO: Move to ../../work/dev/aws.nix
    configs.piwc = let mailLog = false; in {
      domain = "piwine.com";
      extraConfig = { ValidHTTPCodes = "404"; };
      hostAliases = [ "www.piwine.com" "www.pi.wine" "pi.wine" ];
      logFile = if !mailLog then "/var/log/nginx/access.log" else
      "journalctl $OLD_CURSOR -u postfix.service | ${pkgs.perl}/bin/perl ${pkgs.awstats.out}/share/awstats/tools/maillogconvert.pl standard |";
      logFormat = if !mailLog then "1" else "%time2 %email %email_r %host %host_r %method %url %code %bytesd";
      type = if !mailLog then "web" else "mail";
      webService = {
        enable = true;
        hostname = "piwine.com";
        urlPrefix = "/awstats";
      };
    };

  };

  services.hologram-agent.enable = true;
  services.hologram-server = {
    enable = true;
    awsAccount = "";  # AWS Account Number
    awsDefaultRole = "";  # AWS default role
  };
  services.ssm-agent.enable = true;  # Enable AWS SSM agent


  home.packages = [
  ];

}
