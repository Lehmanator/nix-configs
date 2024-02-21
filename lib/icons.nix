{
  config,
  lib,
  pkgs,
  user,
  ...
}: let
  # TODO: Split file?
  # TODO: nixos & hm modules to set style preferences
  style = "round";
  prefer-emoji = false;
in {
  ui = {
    # TODO: Styles: round, square, double, thick
    box = {
      horizontal = "─";
      vertical = "│";
      top-left = "╭";
      top-right = "╮";
      bot-left = "╰";
      bot-right = "╯";
    };
    segment = {
      round = {
        major = {
          left = "";
          right = "";
        };
        minor = {
          left = "";
          right = "";
        };
      };
      angle = {
        minor = {
          right = "";
          left = "";
        };
        major = {
          right = "";
          left = "";
        };
      };
    };
  };

  status = {
    alert = "";
    error = "✖";
    error-alt = "✗";
    info = "";
    ok = "";
    warning = "";
    secure = "󰦝";
    success = "";
    lock = "";
    lock-emoji = "🔒";
  };

  common = {
    arrows.ltr = "➜";
    abbreviation = "…";
    truncate = "…";
  };

  # TODO: Create schema for abbreviating multiple attributes
  # - Who: system, user, remote/machine
  # - For: program,
  # - Attr: secure, read-only, no-perms, encrypted, external, tmp, network,
  # - What: config, data, state, cache, bin, media (type), code, exe
  directories = {
    system = {
      root = "/";
      home = "/~";
      nix = "/";
      media = "/me";
      mnt = "/mn";
      etc = "/";
      boot = "/b";
      esp = "/esp";
      bin = "/";
      data = "/";
      log = "/log";
      run = "/r";
      var = "/v";
      var-run = "/vr";
      www = "/www"; # TODO: www glyph
      xbootldr = "/xb";
    };
    any = "";
    empty = "";

    xdg-base = {
      home = "~";
      root = "~";

      config = "";
      data = "";
      cache = "";
      state = "";
      bin = "";
    };

    xdg-user = {
      scripts = "";
      shell = "";

      apps = "";
      audio = "";
      audiobooks = "";
      backup = "";
      books = "";
      code = "󰗀";
      desktop = "";
      documents = "";
      downloads = "";
      games = "";
      music = "";
      notes = "";
      pictures = "";
      projects = "";
      public = "";
      secrets = "";
      templates = "";
      vaults = "";
      videos = "";
    };

    repos = {
      any = "";
      git = "";
      nix = "";
      nix-config = "";
      nur = "";
    };

    remote = {
      lan = "";
      wan = "";
      computer = "";
      server = "";
      router = "";
      nextcloud = "";
      cloud = "";
      network = "";
    };
    cloud = {
      box = "(Box)";
      google-drive = "(Go)";
      icloud = "(iC)";
      nextcloud = "(NC)";
      onedrive = "(OD)";
    };
    machines = {
      phone = "";
      router = "";
      raspberrypi = "";
      server = "";
      server-lan = "";
      desktop = "";
      laptop = "";
    };
    protocols = {
      ftp = "";
      sftp = "";
      ssh = "";
      nfs = "";
      ipfs = "";
      dav = "";
      s3 = "";
    };
    storage = {
      hdd = "";
      ssd = "";
      nvme = "";
      sdcard = "";
      emmc = "";
      usb = "";
    };
  };

  languages = {nix = "";};
  programs = {
    shell = "";
    vim = "";
    zsh = "";
  };

  shell = {
    insert = "❯";
    normal = "❮";
    segment = "";
    subsegment = "";
    newline = "";
  };
}
