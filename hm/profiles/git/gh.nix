{ config, pkgs, ... }: {
  # gh - GitHub CLI
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings = {
      git_protocol = "ssh";
      aliases = {
        co = "pr checkout";
        pv = "pr view";

        # gh-f - FZF aliases to avoid typing `gh f` before each command
        l = "f -l";
        prs = "f -p";

        # gh-s - FZF search for repos
        user    = "s --user";
        topic   = "s --topic";
        lang    = "s --lang";
        cue     = "s --lang cue";
        jsonnet = "s --lang jsonnet";
        nix     = "s --lang nix";
        nickel  = "s --lang nickel";
        nushell = "s --lang nushell";
        rust    = "s --lang rust";
      };
    };
    extensions = with pkgs; [
      gh-actions-cache    # "actions/gh-actions-cache"
      gh-cal              # "andyfeller/gh-artifact-purge"
      gh-dash             # "divhdr/gh-dash"
      gh-eco              # "jrnxf/gh-eco"
      gh-markdown-preview # "yusukebe/gh-markdown-preview"
      gh-notify           # "meiji163/gh-notify"
      gh-poi              # "seachicken/gh-poi"
      gh-f                # "gennaro-tedesco/gh-f"  # Git workflow w/ FZF 
      gh-s                # "gennaro-tedesco/gh-s"  # Git interactive search repos  w/ FZF
      # gh-i              # "gennaro-tedesco/gh-i"  # Git interactive search issues w/ FZF  # NOTE: added in 24.11
      # gh-ost            # "github/gh-ost"

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

  # gh-dash - GitHub TUI Dashboard
  programs.gh-dash = {
    enable = true;
    settings = {
      issueSections = [
        { title="Issues: Created";    filters="is:open author:@me";   layout.author.hidden=true; }
        { title="Issues: Assigned";   filters="is:open assignee:@me"; }
        { title="Issues: Subscribed"; filters="is:open -author:@me";  limit=200; }
      ];
      prSections = [
        { title="PRs: Mine - Open";  filters="is:open author:@me";           layout.author.hidden=true; }
        { title="PRs: Needs Review"; filters="is:open review-requested:@me"; layout.author.hidden=false; }
        { title="PRs: Subscribed";   filters="is:open -author:@me";          layout.author.hidden=false; limit=200; }
      ];
      repoPaths = {
        ":owner/:repo" = "~/Code/:owner/:repo";
        "Lehmanator/nix*"         = "~/Nix/*";
        "Lehmanator/nix-configs"  = "~/Nix/configs";
        "Lehmanator/clan-configs" = "~/Nix/clan";
      };
    };
  };

  home.packages = [
    #pkgs.ghdorker
  ];

}
