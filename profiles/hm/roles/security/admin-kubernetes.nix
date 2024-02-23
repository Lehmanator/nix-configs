{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
    ./admin-container.nix
  ];

  home.packages = [
    # --- Generic Kubernetes Utils ---
    # TODO: Move to generic admin-kubernetes role
    pkgs.nur.repos.kapack.yamldiff
    pkgs.nur.repos.ProducerMatt.yaml2nix
    pkgs.nur.repos.kira-bruneau.krane
    pkgs.nur.repos.tboerger.kubectl-ktop
    pkgs.nur.repos.tboerger.kubectl-neat
    pkgs.nur.repos.tboerger.kubectl-oomd
    pkgs.nur.repos.tboerger.kubectl-pexec
    pkgs.nur.repos.tboerger.kubectl-realname-diff
    pkgs.nur.repos.tboerger.kubectl-resource-versions
    pkgs.nur.repos.tboerger.kubectl-view-secret
    pkgs.nur.repos.tboerger.kubectl-whoami
  ];

}
