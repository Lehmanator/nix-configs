{ config, lib, pkgs, ... }:
{
  # Unit Ideas:
  # - Run on storage pressure
  # - Notify upon start/stop
  # - Limit CPU, memory, & IO
  #
  # Ideas:
  # - Also reformat / compress files
  # - Symlinks instead of hard links?
  #
  # Utils:
  # - duperemove, dupe-krill, jdupes (enhanced fdupes fork), fdupes, dduper (BTRFS only)
  # https://www.freedesktop.org/software/systemd/man/latest/systemd.service.html
  # https://www.freedesktop.org/software/systemd/man/latest/systemd.unit.html#
  # https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#
  # https://www.freedesktop.org/software/systemd/man/latest/systemd.kill.html#
  # https://www.freedesktop.org/software/systemd/man/latest/systemd.resource-control.html#
  
  systemd.user.services.dedupe-photos = {
    Unit = {
      Description = "Deduplicate photos by replacing duplicate files with hard links";
      Documentation = ["man:dupe-krill(1)"];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${lib.getExe pkgs.dupe-krill} ${config.xdg.userDirs.pictures}";
      # ExecStartPre = "";
      # ExecStartPost = "";
      # ExecReload = "";
      # ExecStop = "";
      # ExecStopPost = "";
      # ExecCondition = "";
    };
  };

  home.packages = [pkgs.dupe-krill];
}
