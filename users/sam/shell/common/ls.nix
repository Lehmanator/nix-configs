{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  # --- Directory Listing -----
  programs.exa = {
    enable = true;
    enableAliases = true;
    git = true;
    icons = true;
    extraOptions = [ "--group-directories-first" ]; #"--header"
  };
  home.shellAliases.l = "exa -a";
}
