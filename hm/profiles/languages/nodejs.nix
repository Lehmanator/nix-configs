{ config, lib, pkgs, ... }:
let
  # NOTE: nodePackages_latest may not be in binary cache. Building nodejs takes a long time.
  latest = false;
  nodePackages = if latest then pkgs.nodePackages_latest else pkgs.nodePackages;
in
{
  imports = [
    ./javascript.nix
    ./json.nix
  ];
  home.packages = [
    nodePackages.npm-check-updates   # CLI to check for NPM package updates
    nodePackages.nodejs              # node.js runtime
    nodePackages.np                  # Better `npm publish`
    nodePackages.nrm                 # NPM registry manager
    nodePackages.node2nix            # Convert npm packages to Nix
    nodePackages.tailwindcss         # CSS framework for rapidly building UIs.
    # pkgs.haskellPackages.nixfromnpm  # Generate Nix expressions from NPM packages # Broken: 2025-01-21
    pkgs.npm-lockfile-fix            # Add missing integrity & resolved fields to a `package-lock.json` file
    pkgs.prefetch-npm-deps           # 
    pkgs.prefetch-yarn-deps          # 
    pkgs.yarn                        # 
    pkgs.yarn2nix                    # 
    pkgs.yarn-bash-completion        # 
    pkgs.zsh-better-npm-completion   # 
  ];

  programs.helix.extraPackages = [
    pkgs.dockerfile-language-server-nodejs     #
    pkgs.svelte-language-server                # 
    pkgs.tailwindcss-language-server           #
    nodePackages.jshint                        # Static analysis tool for JavaScript
    nodePackages.vls                           # Vue language server (pkgs.vue-language-server)
  ];
  programs.neovim.withNodeJs = true;
  programs.vscode = {
    languageSnippets.javascript = {
      # fixme = {
      #   body = ["$LINE_COMMENT FIXME: $0"];
      #   description = "Insert a FIXME remark";
      #   prefix = ["fixme"];
      # };
    };
    extensions = with pkgs.vscode-extensions; [
      christian-kohler.npm-intellisense  # NPM completion
      eg2.vscode-npm-script              # Run NPM scripts
      mskelton.npm-outdated              # Check for outdated packages
    ];
    userSettings = {
      "files.autoSave" = "on";
      "[javascript]"."editor.tabSize" = 4;
    };
    userTasks.tasks = [
      # { type = "shell";
      #   label = "hello task";
      #   command = "echo 'hello'";
      # }
    ];
  };
  programs.zed-editor.extensions = ["svelte" "vue"];

}
