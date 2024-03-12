{ inputs, config, lib, pkgs, ... }:
let
  inherit (inputs.haumea.lib) load loaders matchers transformers;
in
{
  imports = [];

  home.packages = [
    pkgs.nushellFull
    pkgs.nushellPlugins.net
    pkgs.nushellPlugins.regex
    pkgs.nushellPlugins.query
    pkgs.nushellPlugins.gstat
    pkgs.nushellPlugins.format
    pkgs.nu_scripts
    #pkgs.vscode-extensions.thenuprojectcontributors.vscode-nushell-lang
  ];

  programs.nushell = {
    enable = true;

    # https://www.nushell.sh/book/configuration.html#configuration
    configFile = {
      #source = path;
      #text = '''';
      #envFile = {source=path; text='''';};
      #environmentVariables = {};
      #extraConfig = '''';
      #extraEnv = '''';
      #extraLogin = '''';
      #loginFile = {source=path; text='''';};
      #shellAliases = {};
    };
  };

}
