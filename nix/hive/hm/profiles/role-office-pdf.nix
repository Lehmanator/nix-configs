{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    #pkgs.ripgrep-all                          # Ripgrep w/ search in PDFs, eBooks, office docs, archives, emails, & more
    #pkgs.nur.repos.fliegendewurst.ripgrep-all # Ripgrep w/ search in PDFs, eBooks, office docs, archives, emails, & more
    pkgs.nur.repos.mic92.pandoc-bin           # Universal markup converter (static binary)
    pkgs.nur.repos.ondt.csvlens               # Command-line CSV viewer
    pkgs.nur.repos.wamserma.masterpdfeditor4  # PDF Editor (last free version with editing)
    pkgs.nur.repos.xe.zathura                 # Zathura CLI PDF editor with plugins
  ];

  programs.ripgrep.package = pkgs.ripgrep-all;

}
