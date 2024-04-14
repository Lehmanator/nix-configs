{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [ ];
  environment.systemPackages = with pkgs.gnomeExtensions; [
    another-window-session-manager
    duckduckgo-search-provider
    #google-search-provider
    #fuzzy-app-search
    historymanager-prefix-search
    #keyman
    #just-another-search-bar
    remmina-search-provider
    search-light
    ssh-search-provider-reborn
  ];
}
