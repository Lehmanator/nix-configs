{ inputs, cell, ... }:
let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs;
  inherit (inputs.std) lib std;
  pkgs = inputs.nixpkgs; # .legacyPackages;

  # Nix-based devShells:
  # - nixpkgs dev
  # - NUR dev
  # - NixOS config
  # - home-manager config
  # - nix-darwin config
  # - Nix flakes dev
  # - Nix non-flakes dev
  #
  # TODO: Convert to Nixvim config.
  vim-snippet-updateNixFetchGit = ''
    " Helper to preserve the cursor location w/ filters
    function! Preserve(command)
      let w = winsaveview()
      execute a:command
      call winrestview(w)
    endfunction

    " Update fetcher under cursor
    " - NOTE: Might take a while if large fetched path.
    " - Keybind: '<leader>u'
    autocmd FileType nix map <nowait> <leader>u :call Preserve("%!update-nix-fetchgit --location=" . line(".") . ":" . col("."))<CR>
  '';
  # DevShell configs:
  # - VSCodium w/ config & plugins
  # - Nixvim w/ config & plugins
  # - Git repos w/ auto-pull/auto-updating
  #l.mapAttrs (_: lib.dev.mkShell)
in
inputs.nix-alien.devShells.default
#lib.dev.mkShell {
#  name = "nix-alien: Run foreign binaries";
#  imports = [ std.devshellProfiles.default ];
#  # TODO: Split packages into Nix / NixOS shells
#  # TODO: Import Nix devshell in NixOS devshell
#  packages = [
#  ];
#}
