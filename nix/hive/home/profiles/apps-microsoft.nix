{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.nur.repos.splintah.onedrive
    pkgs.nur.repos.thaumy.microsoft-todo-electron
    #pkgs.evolution-ews
  ];

}
