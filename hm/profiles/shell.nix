{ config, lib, pkgs, ... }:
{
  imports = [
    #inputs.home-extra-xhmm.homeManagerModules.console.program-variables
    #inputs.home-extra-xhmm.homeManagerModules.console.fish
  ];

  # --- To-Dos -------------------------------------------------------
  #services.lorri.enableNotifications = true;
  # TODO: [etesync-dav](etesync.com) - DAV sync server
  # TODO: [espanso](https://espanso.org/docs/matches/basics/) - Text snippet expander
  # TODO: [yazi](https://yazi-rs.github.io/docs/configuration/keymap) - Terminal File Manager
  # TODO: [translate-shell](https://github.com/soimort/translate-shell/wiki/Configuration)
  #programs.translate-shell.settings = {hl="en"; tl=["es" "zh"]; verbose=true;};

  # TODO: Enable pls (ls replacement)
  # https://pls-rs.github.io/pls/cookbooks/starters/

  # --- Shell Completion, Docs, & Help ---
  # TODO: Enable carapace (multi-shell argument completer)
  #programs.carapace.enable = true;

  # --- Package Management & Task Running ---
  # TODO: [topgrade](https://github.com/r-darwish/topgrade/wiki/Step-list)
  #programs.topgrade.settings = { commands={"name item" = "command";}; };

  # --- Password / Secret Management ---
  # TODO: [Tomb](https://dyne.org/software/tomb/) - Encrypt dirs & keep directory structure secret
  # TODO: [pass](https://passwordstore.org) - Simple password encryption using GPG-encrypted files.
  # TODO: [rofi-pass](https://github.com/carnager/rofi-pass) - Rofi menu interface to `pass` secrets
  #services.pass-secret-service.enable = true;
  # ------------------------------------------------------------------

  # TODO: Set in system (NixOS | nix-darwin) config
  #environment.pathsToLink = [
  #  "/share/zsh"
  #  "/share/bash-completion"
  #];

  # home = {
  #   editor = {
  #     executable = types.path | types.str;
  #     package = types.package;
  #   };
  #   visual = { ... };
  #   pager = { ... };
  # };
  # programs.nano = {
  #   enable = false;
  #   package = types.package;
  #   config = ''
  #     // contents of .nanorc //
  #   '';
  # };
  # programs.fish.prompt = types.str;
}
