{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [
  ];

  home.packages = [
    # --- Chess Utils ----------------------------
    pkgs.chessdb             # Chess database
    #pkgs.chessx              # View & analyze chess games

    # --- Chess GUI ------------------------------
    # --- GTK GUI ---
    # TODO: Choose chess UI based on system display & desktop environment
    pkgs.gnome.gnome-chess   # GNOME GTK4 chess app

    # --- X11 GUI ---
    #pkgs.gnuchess           # GNU Chess game
    #pkgs.xchess             # X11 client for GNU chess

    # --- CLI ---
    #pkgs.uchess

    # --- Chess Engines --------------------------
    pkgs.stockfish           # Chess engine

  ];

}
