{ 
  config, lib, pkgs,
  ...
}:

{
  imports = [
  ];

  environment.systemPackages = with pkgs.gnomeExtensions; [
    fuzzy-app-search
    just-another-search-bar
  ];

}
