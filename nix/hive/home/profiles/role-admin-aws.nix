{ inputs, config, lib, pkgs, ... }: {
  programs.bash-my-aws.enable = true; # D: false
  services = {
    awstats = {
      enable = true; # D:false
      dataDir = "/var/lib/awstats"; # D:/var/lib/awstats
      updateAt = "hourly"; # D:null
    };

    hologram-agent.enable = true;
    hologram-server = {
      enable = true;
      awsAccount = ""; # AWS Account Number
      awsDefaultRole = ""; # AWS default role
    };
    ssm-agent.enable = true; # Enable AWS SSM agent
  };

  home.packages = [ ];
}
