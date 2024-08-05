{
  config,
  lib,
  pkgs,
  ...
}: {
  # https://git-scm.com/docs/gitignore
  programs.git.ignores = [
    # --- temp files ---
    "*~"
    "*.swp"
    "*.swo"
    "*.DS_STORE"

    # --- keys ---
    # "*.key"
    "*.priv"
    "*.privkey"
    "*.luks"
    "*.lukskey"
    "*.privatekey"
    "*.p7"
    "*.p11"
    "*.p12"
    "*.psk"
    "*.pkcs"
    "*.pkcs11"
    "*.certificate"
    "*.cert"
    "*.crt"
    "*.pem"
    "*.secrets?(-*)?"

    # --- build artifacts ---
    "result"
    "*.o"

    # --- data ---
    "*.log"
  ];

  home.packages = [
    pkgs.git-ignore # Quickly fetch .gitignore templates from gitignore.io
  ];
}
