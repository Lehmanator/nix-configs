{ inputs, cell, config, lib, pkgs, ... }: {
  imports = [
    #cell.homeProfiles.
    #../../git
    #../../../users/sam/git
  ];
  home.packages = [
    #pkgs.nur.repos.federicoschonborn.devtoolbox  # Multiple developer tools in one GTK4 app (Broken 9/23: pkgs.python310.daltonlens (v0.1.5) miss setuptools_git)
    #pkgs.nur.repos.federicoschonborn.atoms       # Easily manage Linux chroots & containers
    #pkgs.nur.repos.federicoschonborn.atoms-core  # Allows you to create/manage your own chroots & podman containters
    #https://github.com/git-ecosystem/git-credential-manager
    #pkgs.nur.repos."999eagle".git-credential-manager
    # CLI utils for working with JSON & YAML
    pkgs.jq
    pkgs.yq
  ];
}
