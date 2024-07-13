{ inputs, config, lib, pkgs, ... }: {
  #home.packages = [ ];

  # TODO: Make package with extensions as flake output, import in NixOS & home-manager
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = true;
    package = pkgs.vscodium.fhsWithPackages (ps: with ps; [ rustup zlib ]);
    extensions =
      with inputs.nix-vscode-extensions.extensions.${pkgs.system}.open-vsx; [
        activitywatch.aw-watcher-vscode
        arrterian.nix-env-selector
      ];
    globalSnippets = { };
    keybindings = [
      #{key="ctrl+c"; command="editor.action.clipboardCopyAction"; when="textInputFocus"; args=null;};
    ];
    languageSnippets = { };
    mutableExtensionsDir = true;
    userSettings = {
      "files.autoSave" = "off";
      "[nix]"."editor.tabSize" = 2;
    };
    userTasks = {
      version = "2.0.0";
      tasks = [{
        type = "shell";
        label = "Hello task";
        command = "hello";
      }];
    };
  };
}
