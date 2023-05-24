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
    "*~"
    "*.swp"
    "*.swo"
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
    "*.o"
    "*.log"
  ];
}
