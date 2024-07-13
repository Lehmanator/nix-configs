{ inputs, cell
, config, lib, pkgs
, ...
}: {
  packages = [
    pkgs.gitlab-runner
    pkgs.gitlab-ci-local

    # Gitlab CLI client (like hub for gitea)
    pkgs.glab

    # Wrapper for git/hub for Gitlab
    pkgs.lab

    # Daemon used to serve static websites for GitLab users
    pkgs.gitlab-pages

    pkgs.gitlab-clippy
    pkgs.gitlab-container-registry
    pkgs.gitlab-elasticsearch-indexer
    pkgs.gitlab-shell
    pkgs.gitlab-triage
    pkgs.gitlab-workhorse
    pkgs.marge-bot
    pkgs.terraform-providers.gitlab

    # pkgs.vscode-extensions.gitlab.gitlab-workflow
    # pkgs.gnomeExtensions.gitlab-extension
  ];

}
