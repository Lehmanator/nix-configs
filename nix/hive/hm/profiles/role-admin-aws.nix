{ config, lib, pkgs, ... }: {
  # programs.bash-my-aws.enable = true; # D: false

  # NixOS options
  # TODO: Move to ../../nixos/profiles
  # services = {
  #   awstats = {
  #     enable = true; # D:false

  #     # TODO: Add to impermanence
  #     dataDir = "/var/lib/awstats"; # D:/var/lib/awstats
  #     updateAt = "hourly"; # D:null
  #   };

  #   hologram-agent.enable = true;
  #   hologram-server = {
  #     enable = true;
  #     awsAccount = ""; # AWS Account Number
  #     awsDefaultRole = ""; # AWS default role
  #   };
  #   ssm-agent.enable = true; # Enable AWS SSM agent
  # };

  home.packages = [pkgs.awstats];
}
