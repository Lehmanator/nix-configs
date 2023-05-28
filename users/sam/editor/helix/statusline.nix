{ self, inputs
, config, lib, pkgs
, ...
}:
{

  programs.helix.settings.editor.statusline = {

    left = [
      "mode"
      #"separator"
      "file-name"
      "file-modification-indicator"
      "spacer"
      "separator"
      "spacer"
      "version-control"
    ];

    center = [
    ];

    right = [
      "spinner"
      "diagnostics"
      "separator"
      "selections"
      "position"
      "file-encoding"
      "total-line-numbers"
    ];

    mode = {
      normal = "NORMAL";
      insert = "INSERT";
      select = "SELECT";
    };

  };

}
