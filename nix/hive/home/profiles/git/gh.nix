{ config
, pkgs
, ...
}:
{
  programs = {
    # GitHub CLI
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      settings = {
        git_protocol = "ssh";
        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
      };
      extensions = with pkgs; [
        gh-eco #"jrnxf/gh-eco"
        gh-dash #"divhdr/gh-dash"
        gh-actions-cache #"actions/gh-actions-cache"
        gh-markdown-preview #"yusukebe/gh-markdown-preview"
        gh-cal #"andyfeller/gh-artifact-purge"
        #"andyfeller/gh-dependency-report"
        #"andyfeller/gh-montage"
        #"bruxisma/gh-update-branch"
        #"carlsberg/gh-releaser"
        #"chelnak/gh-changelog"
        #"cisagov/gh-skeleton"
        #"cli/gh-webhook"
        #"davidraviv/gh-clean-branches"
        #"despreston/gh-worktree"
        #"einride/gh-dependabot"
        #"Frederick888/gh-ph"
        #"gabe565/gh-profile"
        #"gennaro-tedesco/gh-f"
        #"gennaro-tedesco/gh-i"
        #"gennaro-tedesco/gh-s"
        #"geoffreywiseman/gh-actuse"
        #"github/gh-actions-importer"
        #"github/gh-classroom"
        #"github/gh-copilot"
        #"github/gh-gel"
        #"github/gh-net"
        #"github/gh-projects"
        #"heaths/gh-label"
        #"heaths/gh-template"
        #"hubwriter/gh-quickcs"
        #"ilaif/gh-prx"
        #"jkeech/gh-shell"
        #"joaom00/gh-b"
        #"johnmanjiro13/gh-bump"
        #"jonglo/gh-setup-git-credential-helper"
        #"k1LoW/gh-grep"
        #"kavinvalli/gh-repo-fzf"
        #"kawarimidol/gh-graph"
        #"kawarimidoll/gh-q"
        #"keidarcy/gh-star"
        #"kentaro-m/gh-lspr"
        #"kmcq/gh-combine-dependabot-prs"
        #"koozz/gh-semver"
        #"korosuke613/gh-user-stars"
        #"kyanny/gh-pr-draft"
        #"Link-/gh-token"
        #"matt-bartel/gh-clone-org"
        #"maximousblk/gh-fire"
        #"meiji163/gh-notify"
        #"mislav/gh-branch"
        #"mislav/gh-contrib"
        #"mislav/gh-cp"
        #"mislav/gh-license"
        #"mislav/gh-repo-collab"
        #"mona-actions/gh-repo-stats"
        #"mtoohey/gh-foreach"
        #"nektos/gh-act"
        #"redraw/gh-install"
        #"rethab/gh-project"
        #"rm3l/gh-org-repo-sync"
        #"rnorth/gh-combine-prs"
        #"rsese/gh-actions-status"
        #"samcoe/gh-repo-explore"
        #"sayanarijit/gh-xplr" # TODO: lib.optional config.programs.xplr.enable "sayanarijit/gh-xplr"
        #"seachicken/gh-poi"
        #"securesauce/gh-alerts"
        #"sheepia/gh-userfetch"
        #"sheepla/gh-fzrepo"
        #"stoe/gh-report"
        #"tisonkun/gh-cherry-pick"
        #"twelvelabs/gh-repo-config"
        #"valeriobelli/gh-milestone"
        #"vilmibm/gh-user-status"
        #"yuler/gh-download"
        #"yuler/gh-todo"
      ];
    };

    # Dashboard for gh
    gh-dash = {
      enable = true;
      settings = {
        prSections = [
          { title = "Personal Pull Requests: Open"; filters = "is:open author:@me"; }
        ];
      };
    };

  };

  home.packages = [
    #pkgs.ghdorker
  ];

}
