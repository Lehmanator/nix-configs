{
  inputs,
  cell,
}:
{
  meta.description = "Config(githubsettings): GitHub repository setting config, declaratively.";
}
// (inputs.std.lib.dev.mkNixago inputs.std.data.configs.githubsettings {
  # Writes .github/settings.yaml
  # defaults: https://github.com/divnix/std/blob/5ce7c9411337af3cb299bc9b6cc0dc88f4c1ee0e/src/data/configs/githubsettings.nix
  data = {
    repository = {
      name = "nix-configs";
      inherit (import (inputs.self + /flake.nix)) description;
      homepage = "https://github.com/Lehmanator/nix-configs";
      topics = "Nix, NixOS, std, nixpkgs, dotfiles";
      private = false;
      default_branch = "main";

      allow_squash_merge = true;
      allow_merge_commit = true;
      allow_rebase_merge = true;
      delete_branch_on_merge = true;

      enable_automated_security_fixes = true;
      enable_vulnerability_alerts = true;

      has_issues = true;
      has_projects = true;
      has_wiki = true;
      has_downloads = true;
    };
    #branches = [
    #  { name="main"
    #    protection = {
    #      required_pull_request_reviews: {
    #        required_approving_review_count = null; # null or 1-6
    #        require_code_owner_reviews = true;
    #        dismiss_stale_reviews = true; # Dismiss approved reviews when a new commit is pushed
    #        dismissal_restrictions = { teams=[]; users=[];}; # Who can dismiss pull requests
    #      };
    #      required_status_checks = {
    #        strict=true;
    #        contexts=[]; # List of status checks to require in order to merge into this branch.
    #      };
    #      enforce_admins = false; # Enforce restrictions for admins.
    #      required_linear_history = true; # Prevent merge commits from being pushed to matching branches
    #      restrictions = {apps=[]; users=[]; teams=[];};
    #      };
    #    };
    #];
    #collaborators = [{username=""; permission="pull|push|admin|maintain|triage";}];
    #teams = [{name=""; permission="pull|push|admin|maintain|triage";}];
    #labels = [{name=""; color="CC0000"; description="";}];
    #milestones = [{title=""; description=""; state="open|closed";}];
  };
})
