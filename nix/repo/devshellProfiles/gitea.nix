{ inputs, cell
, config, lib, pkgs
, ...
}: {
  packages = [
    # Runner for Gitea based on act
    pkgs.gitea-actions-runner

    # Runner for Forgejo based on act
    pkgs.forgejo-runner

    # Gitea official CLI client (like hub for gitea)
    pkgs.tea

    # Static websites hosting from Gitea repos
    pkgs.codeberg-pages
  ];

}
