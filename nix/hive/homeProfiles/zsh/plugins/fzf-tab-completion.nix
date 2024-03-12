{pkgs, ...}: {
  # Last Update: 2024/02/06
  # Broken. Relies on LD_PRELOAD method probably broken by NixOS.
  # Also works for other programs using readline
  name = "fzf-tab-completion";
  file = "zsh/fzf-tab-completion.sh";
  src = pkgs.fetchFromGitHub {
    owner = "lincheney";
    repo = "fzf-tab-completion";
    rev = "9616591b74c72c0f716b214c659b2c3c91964e75";
    hash = "sha256-S/vMAtrQ9GZ9qnK2mEPqfPnpsJBZst4UQDTYxwTkqtI=";
  };
}
