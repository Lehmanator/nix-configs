{ config, lib, pkgs, ... }: {
  # myrepos - Tool to update git repos
  # Docs: https://myrepos.branchable.com/
  # TODO: Add plugin: https://github.com/skx/github2mr
  # TODO: Add plugin: https://bitbucket.org/mforbes/mmfhg#rst-header-mr-un-freeze
  programs.mr = {
    enable = true;
    settings = {
      # --- Personal Data & Secrets ----------------------------------
      # TODO: Keepass Database
      # TODO: Pass Database
      # TODO: Gopass Database
      #".local/share/password-store" = {
      #  checkout = "git clone git@github.com:Lehmanator/password-store.git";
      #};

      # --- Personal Projects ----------------------------------------
      nix-configs = {
        checkout = "git clone git@github.com:Lehmanator/nix-configs.git";
        update = "git pull --rebase";
      };

      # --- Personal Forks -------------------------------------------
      nixpkgs = {
        update = "git pull --rebase";
        checkout = ''
          git clone git@github.com:Lehmanator/nixpkgs.git
          git remote add upstream git@github.com:NixOS/nixpkgs.git
        '';
      };
      std = {
        update = "git pull --rebase";
        checkout = ''
          git clone git@github.com:Lehmanator/std.git
          git remote add upstream git@github.com:divnix/std.git
        '';
      };
      hive = {
        update = "git pull --rebase";
        checkout = ''
          git clone git@github.com:Lehmanator/hive.git
          git remote add upstream git@github.com:divnix/hive.git
        '';
      };
      hivebus = {
        update = "git pull --rebase";
        checkout = ''
          git clone git@github.com:Lehmanator/hivebus.git
          git remote add upstream git@github.com:tao3k/hivebus.git
        '';
      };
      omnibus = {
        update = "git pull --rebase";
        checkout = ''
          git clone git@github.com:Lehmanator/omnibus.git
          git remote add upstream git@github.com:tao3k/omnibus.git
        '';
      };
    };
  };
}
