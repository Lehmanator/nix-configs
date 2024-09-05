{ inputs, ... }: {
  # imports = [ ../wrappers ];
  perSystem = { config, lib, pkgs, ... }: {
    packages = {
      # https://github.com/viperML/wrapper-manager
      # Options: https://viperml.github.io/wrapper-manager/docs/module/
      wrappers-all = inputs.wrapper-manager.lib.build {
        inherit pkgs;
        specialArgs = {};
        modules = [
          ({pkgs, ...}: {
            wrappers.nix = {
              basePackage = pkgs.nixVersions.latest;
              env.GIT_WORKSPACE.value = "~/Nix";
              pathAdd = with pkgs; [
                manix
                nix-fast-build
                nix-output-monitor
                nix-serve-ng
                nixd
                nixf
                nixfmt-rfc-style
                nixos-anywhere
                nixos-container
                nixos-firewall-tool
                nixos-generators
                nixos-shell
                nixpacks
                nixpkgs-fmt
                nixpkgs-hammering
                nixpkgs-lint-community
                nixpkgs-lint
                nixpkgs-pytools
                nixpkgs-review
                nixtract
                node2nix
                nuget-to-nix
                sbomnix
                terranix
                toml2nix
                tree-sitter-grammars.tree-sitter-nix
                vimPlugins.nix-develop-nvim
                vimPlugins.vim-addon-nix
                vimPlugins.telescope-manix
                vimPlugins.nvim-treesitter-parsers.nix
                vimPlugins.vim-nix
                vimPlugins.vim-nixhash
                vimPlugins.vim2nix
                update-nix-fetchgit # https://hackage.haskell.org/package/update-nix-fetchgit # TODO: nvim config
                vulnix
                zsh-nix-shell
              ];
            };
          })
          ({pkgs, ...}: {
            # Build a custom nushell wrapper
            # that self-bundles its configuration and dependencies
            # ~/.config/nushell is not neeeded!
            wrappers.nushell = {
              basePackage = pkgs.nushell; 
              env = {
                # TODO: Add starship config or wrapper package for starship.
                # STARSHIP_CONFIG = { name = "STARSHIP_CONFIG"; force = true; value = ../wrappers/starship.toml; };
              };
              extraPackages = [ ];
              pathAdd = with pkgs; [ starship carapace ];
              # appendFlags  = ["--config" ./config.sh "--ascii" ./ascii]; #  Append **after**  args passed to wrapped executable.
              # prependFlags = ["--config" ./config.sh "--ascii" ./ascii]; # Prepend **before** args passed to wrapped executable.

              # Map of renames FROM = TO. Renames every binary /bin/FROM to /bin/TO, adjusting other necessary files.
              renames = {
                nu = "nu-custom";
              };
            };
          })
          ({pkgs, ...}: {
            wrappers.crypto = {
              basePackage = pkgs.git-crypt;
              pathAdd = with pkgs; [
                gpg-tui             # https://github.com/orhun/gpg-tui/blob/master/config/gpg-tui.toml
                gittuf              # https://gittuf.dev/
              ];
            };
          })
          ({pkgs, ...}: {
            wrappers = rec {
              gitlab = lib.recursiveUpdate git {
                pathAdd = with pkgs; [
                  gitlab-timelogs  # https://github.com/phip1611/gitlab-timelogs
                  gitlab-release-cli  # https://gitlab.com/gitlab-org/release-cli
                  gitlab-ci-local     # https://github.com/firecow/gitlab-ci-local
                ];
              };
              github = lib.recursiveUpdate git {
                pathAdd = with pkgs; [
                  github-to-sqlite
                  github-release
                  github-desktop
                  github-commenter
                  github-changelog-generator
                  github-backup
                  # github-copilot-intellij-agent github-copilot-cli
                ];
              };
              git = {
                basePackage = pkgs.gitFull;
                env = {
                  GIT_EDITOR.value = "hx";
                  GIT_WORKSPACE.value = "~/Code";  # TODO: fzf shell config
                  GITHUB_TOKEN.value = "";
                  GITTY_TOKENS.value = "github.com=abc123;gitlab.com=xyz890"; # Perms: repo:status,public_repo,read:user,read:org
                  GITRS_ROOT.value = "$HOME/.local/repos";  # TODO: Change to store path of config file: .gitrs.yaml
                  SSH_PRIVKEY_PATH.value = "$HOME/.ssh/id_ed25519";
                  SSH_PRIVKEY_PASS.value = "";
                };
                extraPackages = [];
                pathAdd = with pkgs; [
                  # --- CLI: Replacements ---
                  gitless          # https://gitless.com/ - Git-compatible alternative w/ simple commit workflow, no staging, independent branches
                  gitoxide         # https://github.com/Byron/gitoxide - Git CLI in Rust
                  gitsign          # https://github.com/sigstore/gitsign - Sign commits with Sigstore instead of keys
                  gitwatch         # https://github.com/gitwatch/gitwatch - Watch FS & auto-stage changes to git repo.
                  rs-git-fsmonitor # https://github.com/jgavris/rs-git-fsmonitor

                  # --- CLI: External ---
                  cocogitto        # https://github.com/oknozor/cocogitto - Set of cli tools for the conventional commit and semver specifications
                  git-annex        # https://git-annex.branchable.com/
                  git-run          # https://mixu.net/gr/ - Multiple git repository management tool
                  git-revise       # https://github.com/mystor/git-revise - Efficiently update, split, and rearrange git commits
                  git-repo-updater # https://github.com/earwig/git-repo-updater - Easily update multiple Git repositories at once
                  git-reparent     # https://github.com/MarkLodato/git-reparent - Git command to recommit HEAD with a new set of parents
                  git-remote-gcrypt # https://spwhitton.name/tech/code/git-remote-gcrypt - Git remote helper for GPG-encrypted remotes
                  git-relevant-history
                  git-releaser
                  git-recent
                  git-radar
                  git-pw
                  git-publish
                  git-ps-rs
                  git-privacy
                  git-open
                  git-octopus
                  git-nomad
                  git-my
                  git-mit
                  git-machete
                  git-lfs
                  git-latexdiff
                  git-interactive-rebase-tool
                  git-instafix
                  git-imerge
                  git-ignore
                  git-igitt
                  git-hub
                  git-hound
                  git-graph
                  git-gone
                  git-get
                  git-fixup
                  git-fire
                  git-filter-repo
                  git-fame
                  git-extras
                  git-delete-merged-branches
                  git-crypt
                  git-credential-oauth
                  git-credential-manager
                  git-credential-keepassxc
                  git-credential-gopass
                  git-crecord
                  git-codeowners
                  git-cliff
                  git-chglog
                  git-cache
                  git-bug-migration
                  git-bug
                  git-brunch
                  git-branchstack
                  # git-branchless
                  git-big-picture
                  git-bars
                  git-backdate
                  git-autoshare
                  git-autofixup
                  git-archive-all
                  git-annex-utils
                  git-annex-remote-rclone
                  # git-annex-remote-googledrive
                  git-annex-remote-dbx
                  # git-annex-metadata-gui
                  git-annex
                  git-aggregator
                  git-agecrypt
                  git-absorb
                  git-quickfix     # https://github.com/siedentop/git-quickfix
                  git-quick-stats  # https://github.com/arzzen/git-quick-stats
                  git-secret       # https://git-secret.io/ - Tool to store private data inside git repo
                  git-secrets      # https://github.com/awslabs/git-secrets - Prevent commiting secrets
                  git-series       # https://github.com/git-series/git-series - Help w/ formatting git patches for review on mailing lists
                  git-sizer        # https://github.com/github/git-sizer - Compute various size metrics for a Git repository
                  git-spice        # https://abhinav.github.io/git-spice/ - Manage stacked Git branches
                  git-stack        # https://github.com/gitext-rs/git-stack - Stacked branch management for Git
                  git-standup      # https://github.com/kamranahmedse/git-standup - Remember what you did
                  git-stree        # http://deliciousinsights.github.io/git-stree - Better Git subtree helper command
                  git-subrepo      # https://github.com/ingydotnet/git-subrepo - Git submodule alternative
                  git-subtrac      # https://github.com/apenwarr/git-subtrac - Keep content for your git submodules in one place: parent repo
                  git-sync         # https://github.com/simonthum/git-sync - Script to automatically synchronize a git repository
                  git-team         # https://github.com/hekmekk/git-team - CLI to manage & enhance commit messages with co-authors
                  git-test         # https://github.com/spotify/git-test - Test ur commits
                  git-together     # https://github.com/kejadlen/git-together - Better commit attribution w/o messing w/ git workflow
                  git-toolbelt     # https://github.com/nvie/git-toolbelt - Suite of useful git commands that aid w/ scripting or CLI usage
                  git-town         # https://www.git-town.com/ - Generic high-level support for git-flow workflows. Conf: .git-branches.toml
                  git-trim         # https://github.com/foriequal0/git-trim - Auto trim branches whose tracking remote refs are merged or gone
                  git-workspace    # https://github.com/orf/git-workspace - Sync personal & work git repos from multiple providers
                  git-when-merged  # https://github.com/mhagger/git-when-merged - Find out when/why a commit was merged
                  git-vendor       # https://github.com/brettlangdon/git-vendor - Git command for managing vendored deps
                  git-vanity-hash  # https://github.com/prasmussen/git-vanity-hash - Util to create commit hashes w/ specific prefix
                  git-up           # https://github.com/msiemens/PyGitUp - Git pull replacement that rebases all local branches when pulling
                  git-upstream     # https://github.com/9999years/git-upstream - Shortcut: git push --set-upstream
                  git2cl           # https://savannah.nongnu.org/projects/git2cl - Generate GNU style changelogs from git logs
                  gita             # https://github.com/nosarthur/gita - Command-line tool to manage multiple git repos
                  gitbatch         # https://github.com/isacikgoz/gitbatch - Run batch git UI commands
                  gitcs            # https://github.com/knbr13/gitcs - Generate contributions graph
                  githooks         # https://github.com/gabyx/Githooks - Git hooks manager
                  gitjacker           # https://github.com/liamg/gitjacker - Leak git repos from misconfigured websites
                  gitleaks         # https://github.com/gitleaks/gitleaks - Detect leakage of secrets in Git repo. w/ pre-commit hooks, GH Actions. Conf: https://github.com/zricethezav/gitleaks/blob/master/config/gitleaks.toml
                  gitlint          # https://github.com/jorisroovers/gitlint - Linting for commit messages
                  gitls            # https://github.com/hahwul/gitls - Enumerate git repo URL from list of URL/User/Org
                  gitmoji-cli      # https://github.com/carloscuesta/gitmoji-cli - Add emoji to git commit messages
                  gitrs            # https://github.com/mccurdyc/gitrs - Declaratively manage git repos
                  gitty            # https://github.com/muesli/gitty/ - Contextual info about your git projects
                  gitversion       # https://gitversion.net/ - Git log -> SemVer
                  legitify         # https://github.com/Legit-Labs/legitify - Detect & fix misconfigurations & security risks of GitHub assets
                  mgitstatus       # https://github.com/fboender/multi-git-status - Run git status on multiple repos
                  stgit            # https://stacked-git.github.io/    - Patch manager
                  top-git          # https://github.com/mackyle/topgit - 
                  tailscale-gitops-pusher # Push tailscale ACLs from GitOps

                  # --- TUI ---
                  gitnr            # https://github.com/reemus-dev/gitnr - .gitignore template fetcher TUI
                  gitty            # https://github.com/muesli/gitty/ - Show relevant issues, PRs, & changes at a glance.
                  gitu             # https://github.com/altsem/gitu - Git TUI inspired by Magit. Conf: https://github.com/altsem/gitu/blob/master/src/default_config.toml
                  gitui            # https://github.com/extrawurst/gitui - Rust Git TUI. Good, but lazygit seems better.
                  lazygit          # https://github.com/jesseduffield/lazygit - Conf: https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md

                  # --- FZF TUI ---
                  fzf-git-sh         # - Tab completion for git with fzf
                  md-tui             # https://github.com/henriklovhaug/md-tui - Markdown renderer TUI
                  zsh-forgit         # https://github.com/wfxr/forgit - Interactive git w/ FZF
                  

                  # --- Desktop & GUI ---
                  gitfs              #  - Git-based FUSE filesystem. FS changes make commits to remotes.
                  gitg               # https://gitlab.gnome.org/GNOME/gitg - GNOME GUI client for git repos
                  # gittyup          # https://murmele.github.io/Gittyup - Graphical git client w/ tools to help understand git history
                  # gitkraken           # https://www.gitkraken.com/git-client
                  # gitnuro          # https://gitnuro.com - Clean GUI app for git w/ good history view
                  # legit            # https://github.com/icyphox/legit - Web frontend for git (--config $XDG_CONFIG_HOME/legit.yaml)
                  # oh-my-git        # https://ohmygit.org               - Git tutorial game

                  # --- Servers ---
                  # gitit              # https://hackage.haskell.org/package/gitit-0.15.1.2#readme - Wiki via git repo.
                  # gitolite         # https://gitolite.com/gitolite/non-core - Git host server w/ ACLs w/o using UNIX users
                  # gitstats         # https://gitstats.sourceforge.net/ - Git history stats generator
                  # stagit           # https://git.codemadness.org/stagit/file/README.html - Static site generator for git repos

                  # --- Plugins: Git ---
                  # TODO: credential-helpers
                  pass-git-helper  # https://github.com/languitar/pass-git-helper

                  # --- Plugins: Other ---
                  # gitmux           # https://github.com/arl/gitmux - Tmux plugin w/ git status bar
                  # terraform-providers.gitlab
                  # terraform-providers.github
                  # terraform-backend-git
                ];
              };
            };
          })
        ];
      };
    };
  };
}
