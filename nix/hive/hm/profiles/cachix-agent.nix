{ config, lib, pkgs
, osConfig
, ...
}:
# let
#   reuse-system = true;
#   hasSystem = (lib.hasAttrByPath ["sops" "secrets" "cachix-agent-token"] osConfig) && (lib.hasAttrByPath ["networking" "hostName"] osConfig);
# in
{
  services.cachix-agent = {
    enable = true;

    # TODO: nix-darwin / nixos-wsl?
    # TODO: Consider "home-manager-username@config.networking.fqdn" ?
    name = "home-manager-${config.home.username}@" + (
      if      lib.hasAttrByPath ["networking" "fqdn"    ] osConfig
       then osConfig.networking.fqdn
      else if lib.hasAttrByPath ["networking" "hostName"] osConfig
       then osConfig.networking.hostName
       else "standalone"
    );

    credentialsFile = if lib.hasAttrByPath ["sops" "secrets" "cachix-agent-token"] osConfig
      then osConfig.sops.secrets.cachix-agent-token.path  # "/etc/cachix-agent.token";
      else   config.sops.secrets.cachix-agent-token.path  # "/home/<user>/.config/cachix-agent.token"
    ;
      
    # package = pkgs.cachix;
    # host    = null; #"";
    # profile = null; # "home-manager" "system";
    # verbose = false;
  };

  sops.secrets = {
    cachix-activate-token = lib.mkIf config.services.cachix-agent.enable {};
    cachix-agent-token    = lib.mkIf config.services.cachix-agent.enable {};
    cachix-signing-key    = lib.mkIf config.services.cachix-agent.enable {};
  };
}
