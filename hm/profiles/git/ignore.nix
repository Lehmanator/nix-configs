{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  # https://git-scm.com/docs/gitignore
  programs.git.ignores = [
    # --- temp files ---
    "*~"
    "*.swp"
    "*.swo"

    # --- keys ---
    "*.key"
    "*.privkey"
    "*.luks"
    "*.lukskey"
    "*.privatekey"
    "*.p7"
    "*.p11"
    "*.psk"
    "*.pkcs"
    "*.cert"
    "*.crt"
    "*.pem"

    # --- build artifacts ---
    "result"
    "*.o"

    # --- data ---
    "*.log"
  ];
}
