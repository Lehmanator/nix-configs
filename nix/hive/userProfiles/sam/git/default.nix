{ inputs, config, lib, pkgs, ... }: {
  programs = {
    git = {
      includes = [
        # --- Users ---
        # TODO: Import all users in ./users/default.nix
        (import ./public.nix)
        (import ./personal.nix)
        (import ./gnome.nix)
        (import ./gaming.nix)
        #(import ./work.nix)

        # TODO: Extra conditionals
        # { path = "~/path/to/config.inc"; }
        # { path = "~/path/to/conditional.inc";
        #   condition = "gitdir:~/src/dir";
        # }
      ];
      #userEmail = "";
      #userName = "";
    };

    mr.settings = {
      config = {
        checkout = "git clone git@github.com:lehmanator/nix-configs.git";
        update = "git pull";
      };
      nixpkgs = {
        checkout = "git clone git@github.com:NixOS/nixpkgs.git";
        update = "git pull --rebase";
      };
      nur = { checkout = "git clone git@github.com:lehmanator/nur-repo.git"; };
      passwords = {
        checkout = "git clone git@github.com:lehmanator/keepass.git";
        update = "git pull";
      };
    };
  };
}
