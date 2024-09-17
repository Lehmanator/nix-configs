{ inputs, config, lib, pkgs, osConfig, ... }:
{
  programs = {
    git = {
      userName  = "Sam Lehman";
      userEmail = "github@samlehman.dev";

      includes = [
        # TODO: Import all files in directory w/ Haumea.
        # TODO: Handle all different git forges I interact with
        # - [ ] TODO: github.com
        # - [ ] TODO: gitlab.com
        # - [ ] TODO: codeberg.org
        # - [ ] TODO: gitlab.gnome.org
        # - [ ] TODO: git.auxolotl.org
        # - [ ] TODO: git.lix.systems
        # - [ ] TODO: git.clan.lol
        (import ./public.nix)
        (import ./personal.nix)
        (import ./gnome.nix)
        (import ./gaming.nix)
        (import ./work.nix)

        # Generic local for quick-n-dirty overrides w/o rebuild.
        # { path = "${config.xdg.configHome}/git/host-${osConfig.networking.hostName}.inc";}
        { path = "${config.xdg.configHome}/git/local.inc"; }
        { path = "${config.xdg.configHome}/git/user-${config.home.username}.inc"; }


        # --- Users ---
        # TODO: Import all users in ./users/default.nix
        # { #path = "";
        #   condition = "hasconfig:remote.*.url:git@github.com:Lehmanator/**";
        #   contents = {
        #     user = {
        #       email = "github@samlehman.dev";
        #       name = "Sam Lehman";
        #     };
        #   };
        # }
        # { #path = "";
        #   condition = "hasconfig:remote.*.url:git@github.com:lehmanator/**";
        #   contents = {
        #     user = {
        #       email = "github@samlehman.dev";
        #       name = "Sam Lehman";
        #     };
        #   };
        # }

        # TODO: Extra conditionals
        # { path = "~/path/to/config.inc"; }
        # { path = "~/path/to/conditional.inc";
        #   condition = "gitdir:~/src/dir";
        # }
      ];
    };

    mr.settings = {
      nixpkgs   = { checkout = "git clone git@github.com:NixOS/nixpkgs.git";          update = "git pull --rebase"; };
      config    = { checkout = "git clone git@github.com:Lehmanator/nix-configs.git"; update = "git pull"; };
      nur       = { checkout = "git clone git@github.com:Lehmanator/nur-repo.git";                         };
      passwords = { checkout = "git clone git@github.com:Lehmanator/keepass.git";     update = "git pull"; };
    };
  };
}
