{ stdenv
, vscodium
, vscode-extensions
, vscode-with-extensions
, #, vscode-marketplace-release , open-vsx , open-vsx-release
  lib
, ...
}@commonArgs:
lib.debug.traceIf (commonArgs ? cell) commonArgs
  (vscode-with-extensions.override {
    vscode = vscodium.fhsWithPackages (ps: with ps; [ rustup zlib ]);
    vscodeExtensions =
      #with inputs.nix-vscode-extensions.extensions.${stdenv.system}.open-vsx;
      with vscode-extensions;
      #with vscode-marketplace-release;
      #with open-vsx;
      [
        activitywatch.aw-watcher-vscode
        arrterian.nix-env-selector
      ];
  })
