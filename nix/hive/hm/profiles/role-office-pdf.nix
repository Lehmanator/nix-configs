{  config, lib, pkgs , ... }: {
  home.packages = [
    pkgs.nur.repos.mic92.pandoc-bin           # Universal markup converter (static binary)
    pkgs.nur.repos.ondt.csvlens               # Command-line CSV viewer
    pkgs.nur.repos.wamserma.masterpdfeditor4  # PDF Editor (last free version with editing)
    # pkgs.nur.repos.xe.zathura                 # Zathura CLI PDF editor with plugins. Broken: 2024-06-03
    pkgs.zathura
  ];

  # Ripgrep w/ search in PDFs, eBooks, office docs, archives, emails, & more
  programs.ripgrep.package = lib.mkForce pkgs.ripgrep-all;

  #programs.neovim.plugins.extraPackages = [pkgs.vimPlugins.nvim-treesitter-parsers.zathurarc];
}
