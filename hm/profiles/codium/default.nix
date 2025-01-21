{ inputs, config, lib, pkgs, ... }:
{
  # https://nixos.wiki/wiki/Visual_Studio_Code
  # TODO: Use VSCodium
  # TODO: Add extensions
  # TODO: Add FOSS extension marketplace
  imports = [
    inputs.nix-vscode-ide.homeManagerModules.default
    inputs.nix-vscode-extensions.homeManagerModules.default
  ];

  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = true;
    mutableExtensionsDir = true;
    package = pkgs.vscodium;
    extensions = [];
    globalSnippets = {
      fixme = {
        prefix = [ "fixme" ];
        description = "Insert a FIXME remark";
        body = [ "$LINE_COMMENT FIXME: $0" ];
      };
      info = {
        prefix = [ "info" ];
        description = "Insert a INFO remark";
        body = [ "$LINE_COMMENT INFO: $0" ];
      };
      note = {
        prefix = [ "note" ];
        description = "Insert a NOTE remark";
        body = [ "$LINE_COMMENT NOTE: $0" ];
      };
      todo = {
        prefix = [ "todo" ];
        description = "Insert a TODO remark";
        body = [ "$LINE_COMMENT TODO: $0" ];
      };
      warn = {
        prefix = [ "warn" ];
        description = "Insert a WARN remark";
        body = [ "$LINE_COMMENT WARN: $0" ];
      };
    };
    keybindings = [
      { key = "ctrl+c";
        command = "editor.action.clipboardCopyAction";
        when = "textInputFocus";
        args = { direction = "up"; };
      }
    ];
    # Similar to globalSnippets, but for specific languages.
    languageSnippets = {};
    userSettings = {
      "files.autoSave" = "off";
      # "[nix]"."editor.tabSize" = 2;
    };
    userTasks = {
      version = "2.0.0";
      tasks = [
        # { type = "shell";
        #   label = "Hello task";
        #   command = "hello";
        # }
      ]
    }
  };
}
