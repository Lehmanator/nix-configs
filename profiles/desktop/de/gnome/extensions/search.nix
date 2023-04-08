{ 
  config, lib, pkgs,
  ...
}:

{
  imports = [
  ];

  environment.systemPackages = with pkgs.gnomeExtensions; [
    duckduckgo-search-provider
    google-search-provider
    fuzzy-app-search
    keyman
    just-another-search-bar
    remmina-search-provider
    ssh-search-provider-reborn
  ];

}
