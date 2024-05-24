{ config, lib, pkgs, ... }: {
  # https://git-scm.com/docs/gitignore
  programs.git.ignores = [
    # --- Temp Files ---
    "*~"
    "*.sw(p|o|q|r|s)"
    "*.DS_STORE"

    # --- Keys & Secrets ---
    "*.(gpg|luks|priv(ate)?|ssh)?key(s.txt)?"
    "*.priv"
    "*.luks(key)?"
    "*.p(kcs)?(1(1|2)|7)?"
    "*.psk"
    "*.(ca)?ce?rt(ificate)?"
    "*.pem"
    "*.secrets?(-*)?"
    "id*_*(rsa|ed25519|ecdsa)(-*)?"

    # --- Build Artifacts ---
    "result"
    "*.o"
    "gdb.txt"

    # --- Data ---
    ".cache/"
    ".data/"
    "(*.)?logs?"
    "*.qcow*" # VM volumes

    # --- Metadata ---
    "ctags"
    "tags"
    "*.fd"
    ".direnv/"

    # --- Manual Exclusion ---
    ".old"
    ".excl"
    "excl/"

    # --- Accidental ---
    "wl-(copy|paste)"
    "(b|c)at"
    "n?v(im)?"
  ];

  home.packages = [
    pkgs.git-ignore # Quickly fetch .gitignore templates from gitignore.io
  ];
}
