{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./cli.nix
    #./database.nix
    #./engines.nix
    #./utils.nix

    #./client-cli.nix
    #./client-tui.nix
    #./client-gtk.nix
    #./client-qt.nix
  ];

  home.packages = [
    # --- Chess Engines --------------------------
    pkgs.stockfish # Chess engine

    # --- Chess Utils ----------------------------
    pkgs.chessdb # Chess database
    #pkgs.chessx # View & analyze chess games

    # --- Clients --------------------------------
    # TODO: Choose chess UI based on system display & desktop environment
    #pkgs.uchess              # CLI
    #pkgs.gnome.gnome-chess   # GTK4 chess app
    #pkgs.gnuchess            # X11 GNU Chess game
    #pkgs.xchess              # X11 client for GNU chess
  ];

}
